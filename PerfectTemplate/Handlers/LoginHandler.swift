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
    func dataValidation() -> Bool {
        guard request.param(name: "username") != nil && request.param(name: "password") != nil else {
            ErrorHandler(request: request, response: response).process()
            return false
        }
        return true
    }

    func process() {
        response.setHeader(.contentType, value: "application/json")
        guard dataValidation() else { return }
        let json: [String: Any] = [
            "result": 1,
            "user": [
                "id_user": 123,
                "user_login": "geekbrains",
                "user_name": "John",
                "user_lastname": "Doe"
            ]
        ]

        do {
            try response.setBody(json: json)
        } catch {
            print(error)
        }
        response.completed()
    }
}
