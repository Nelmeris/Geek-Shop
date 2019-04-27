//
//  ChangeUserDataHundler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import Foundation
import PerfectHTTP

class ChangeUserDataHundler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension ChangeUserDataHundler {
    func dataValidation() -> Bool {
        guard request.param(name: "id_user") != nil &&
            request.param(name: "username") != nil &&
            request.param(name: "password") != nil &&
            request.param(name: "email") != nil &&
            request.param(name: "gender") != nil &&
            request.param(name: "credit_card") != nil &&
            request.param(name: "bio") != nil
            else {
                ErrorHandler(request: request, response: response).process()
            return false
        }
        return true
    }
    
    func process() {
        response.setHeader(.contentType, value: "application/json")
        guard dataValidation() else { return }
        let json: [String: Any] = [
            "result": 1
        ]
        
        do {
            try response.setBody(json: json)
        } catch {
            print(error)
        }
        response.completed()
    }
}
