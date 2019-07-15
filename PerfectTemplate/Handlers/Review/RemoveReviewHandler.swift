//
//  RemoveReviewHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 30/04/2019.
//

import Foundation
import PerfectHTTP

class RemoveReviewHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension RemoveReviewHandler {
    
    func dataValidation() -> Bool {
        guard request.param(name: "id_comment") != nil
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
