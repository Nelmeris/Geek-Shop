//
//  LogoutHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import Foundation
import PerfectHTTP

class LogoutHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension LogoutHandler {

    func process() {
        guard let _ = request.param(name: "user_id") else {
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
            return
        }
        do {
            try sendingResponse()
        } catch {
            ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
        }
    }
    
    private func sendingResponse() throws {
        response.setHeader(.contentType, value: "application/json")
        try response.setBody(json: Response())
        response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
    }
    
}
