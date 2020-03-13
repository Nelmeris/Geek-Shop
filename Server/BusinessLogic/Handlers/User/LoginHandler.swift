//
//  LoginHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import Foundation
import PerfectHTTP

class LoginHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension LoginHandler {

    func process() {
        switch validate() {
        case .success(let data):
            switch loginProcess(with: data) {
            case .success(let user):
                do {
                    try sendingResponse(with: user)
                } catch {
                    ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
                }
            case .failure:
                ErrorHandler(request: request, response: response).process(with: "Неверная пара логин/пароль")
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        }
    }
    
    typealias LoginData = (username: String, password: String)
    enum ValidateResult {
        case success(LoginData)
        case badData
    }
    
    private func validate() -> ValidateResult {
        guard let username = request.param(name: "username"),
            let password = request.param(name: "password") else {
                return .badData
        }
        return .success((username, password))
    }
    
    enum LoginResult {
        case success(User)
        case failure
    }
    
    private func loginProcess(with data: LoginData) -> LoginResult {
        let context = CoreDataStack.shared.mainContext
        guard let user = User.fetchByUsername(data.username, in: context),
            user.password == data.password else {
                return .failure
        }
        return .success(user)
    }
    
    private func sendingResponse(with user: User) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(user: user))
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let user: User
    }
    
}
