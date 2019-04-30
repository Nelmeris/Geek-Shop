//
//  GetGoodByIdHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 27/04/2019.
//

import Foundation
import PerfectHTTP

class GetGoodByIdHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension GetGoodByIdHandler {
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
            "result": 1,
            "product_name": "Название",
            "product_price": 123,
            "product_description": "Описание"
        ]

        do {
            try response.setBody(json: json)
        } catch {
            print(error)
        }
        response.completed()
    }
}
