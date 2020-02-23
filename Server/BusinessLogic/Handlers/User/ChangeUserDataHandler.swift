//
//  ChangeUserDataHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import Foundation
import PerfectHTTP

class ChangeUserDataHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension ChangeUserDataHandler {

    func process() {
        switch validate() {
        case .success(let user, let newData):
            do {
                user.update(from: newData)
                try sendingResponse(with: user)
                let context = CoreDataStack.shared.mainContext
                CoreDataStack.shared.saveContext(context)
            } catch {
                ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        case .userNotFound:
            ErrorHandler(request: request, response: response).process(with: "Пользователь не найден")
        case .usernameBusy:
            ErrorHandler(request: request, response: response).process(with: "Пользователь с таким именем уже существует")
        }
    }
    
    enum ValidateResult {
        case success(user: User, newData: UserData)
        case badData
        case userNotFound
        case usernameBusy
    }
    
    private func validate() -> ValidateResult {
        guard let userIdStr = request.param(name: "user_id"),
            let userId = Int(userIdStr),
            let username = request.param(name: "username") else {
                return .badData
        }
        let context = CoreDataStack.shared.mainContext
        guard let user = User.fetchById(userId, in: context) else {
            return .userNotFound
        }
        var password: String!
        if let newPassword = request.param(name: "password"), !newPassword.isEmpty {
            password = newPassword
        } else {
            password = user.password
        }
        let data = UserData(username: username, password: password,
                            name: request.param(name: "name"),
                            surname: request.param(name: "surname"),
                            email: request.param(name: "email"),
                            gender: request.param(name: "gender"),
                            creditCard: request.param(name: "credit_card"),
                            bio: request.param(name: "bio"))
        return .success(user: user, newData: data)
    }
    
    private func sendingResponse(with user: User) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(user: user))
        self.response.completed()
    }

    struct Response: Encodable {
        let result = 1
        let message = "Смена данных прошла успешно!"
        let user: User
    }
    
}
