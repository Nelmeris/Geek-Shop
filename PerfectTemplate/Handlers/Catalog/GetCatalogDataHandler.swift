//
//  GetCatalogDataHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import Foundation
import PerfectHTTP

class GetCatalogDataHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension GetCatalogDataHandler {
    
    func dataValidation() -> Bool {
        guard request.param(name: "page_number") != nil &&
            request.param(name: "category_id") != nil
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
                "id_product": 123,
                "product_name": "Ноутбук",
                "price": 45600
            ],
            [
                "id_product": 456,
                "product_name": "Мышка",
                "price": 1000
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
