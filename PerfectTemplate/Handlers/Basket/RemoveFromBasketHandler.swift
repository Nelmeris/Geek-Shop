//
//  DeleteFromBasketHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 14/05/2019.
//

import Foundation
import PerfectHTTP

class RemoveFromBasketHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension RemoveFromBasketHandler {
    
    func dataValidation() -> Bool {
        guard request.param(name: "id_product") != nil
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
