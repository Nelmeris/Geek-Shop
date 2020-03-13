//
//  GetGoodsHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//

import Foundation
import PerfectHTTP

class GetGoodsHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    let productDB: ProductDBService

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
        self.productDB = ProductDBService()
    }
}

extension GetGoodsHandler {

    func process() {
        do {
            let products = try productDB.load()
            try sendingResponse(with: products)
        } catch {
            ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
        }
    }
    
    private func sendingResponse(with products: [Product]) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(products: products))
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let products: [Product]
    }
    
}
