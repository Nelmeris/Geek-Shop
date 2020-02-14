//
//  GetBasketHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 14/05/2019.
//

import Foundation
import PerfectHTTP

class GetBasketHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension GetBasketHandler {
    
    func dataValidation() -> Bool {
        guard request.param(name: "user_id") != nil
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
            "amount": 46600,
            "count_goods": 2,
            "contents": [
                [
                    "id_product": 123,
                    "product_name": "Ноутбук",
                    "price": 45600,
                    "quantity": 1
                ],
                [
                    "id_product": 456,
                    "product_name": "Мышка",
                    "price": 1000,
                    "quantity": 1
                ]
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
