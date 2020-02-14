//
//  RegisterHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import Foundation
import PerfectHTTP

class RegisterHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    let db: UserDBService

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
        self.db = UserDBService()
    }
}

extension RegisterHandler {

    func process() {
        switch validate() {
        case .success(let data):
            do {
                let user = try db.save(with: data)
                try sendingResponse(with: user)
            } catch {
                ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        case .usernameBusy:
            ErrorHandler(request: request, response: response).process(with: "Пользователь с таким именем уже существует")
        }
    }
    
    enum ValidateResult {
        case success(UserData)
        case badData
        case usernameBusy
    }
    
    private func validate() -> ValidateResult {
        guard let username = request.param(name: "username"),
            let password = request.param(name: "password") else {
                return .badData
        }
        guard try! db.load(username: username) == nil else {
            return .usernameBusy
        }
        return .success(UserData(username: username, password: password,
                                 name: request.param(name: "name"),
                                 surname: request.param(name: "surname"),
                                 email: request.param(name: "email"),
                                 gender: request.param(name: "gender"),
                                 creditCard: request.param(name: "credit_card"),
                                 bio: request.param(name: "bio")))
    }
    
    private func sendingResponse(with user: User) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(user: user))
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let message = "Регистрация прошла успешно!"
        let user: User
    }
    
}
