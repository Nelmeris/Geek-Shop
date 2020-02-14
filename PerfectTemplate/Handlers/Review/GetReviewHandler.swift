//
//  GetReviewHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 30/04/2019.
//

import Foundation
import PerfectHTTP

class GetReviewHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension GetReviewHandler {
    
    func dataValidation() -> Bool {
        guard request.param(name: "product_id") != nil
            else {
                ErrorHandler(request: request, response: response).process()
                return false
        }
        return true
    }
    
    func process() {
        response.setHeader(.contentType, value: "application/json")
        guard dataValidation() else { return }
        let json: [[String: Any]] = [
            [
                "user": [
                    "id_user": 123,
                    "user_login": "geekbrains",
                    "user_name": "John",
                    "user_lastname": "Doe"
                ],
                "text": "Some text"
            ],
            [
                "user": [
                    "id_user": 12,
                    "user_login": "nelmeris",
                    "user_name": "Alex",
                    "user_lastname": "Morgan"
                ],
                "text": "Some text"
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
