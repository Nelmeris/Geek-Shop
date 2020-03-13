//
//  AddReviewHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 30/04/2019.
//

import Foundation
import PerfectHTTP

class AddReviewHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension AddReviewHandler {
    
    func dataValidation() -> Bool {
        guard request.param(name: "product_id") != nil &&
            request.param(name: "text") != nil
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
            "result": 1,
            "userMessage": "Ваш отзыв был передан на модерацию!"
        ]
        
        do {
            try response.setBody(json: json)
        } catch {
            print(error)
        }
        response.completed()
    }
    
}
