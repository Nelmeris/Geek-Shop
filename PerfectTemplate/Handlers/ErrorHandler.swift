//
//  ErrorHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import Foundation
import PerfectHTTP

class ErrorHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension ErrorHandler {
    
    func process() {
        process(with: "Некорректный запрос")
    }
    
    func process(with message: String) {
        response.setHeader(.contentType, value: "application/json")
        let error = ErrorResponse(errorMessage: message)
        do {
            try response.setBody(json: error)
        } catch {
            print(error)
        }
        response.completed()
    }
    
}

struct ErrorResponse: Codable {
    let result: Int = 0
    let errorMessage: String
}
