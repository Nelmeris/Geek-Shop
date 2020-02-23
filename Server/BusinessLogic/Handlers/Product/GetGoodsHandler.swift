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

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension GetGoodsHandler {

    func process() {
        do {
            let context = CoreDataStack.shared.mainContext
            let products = Product.fetchAll(in: context)
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
