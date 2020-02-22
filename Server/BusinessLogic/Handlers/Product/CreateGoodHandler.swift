//
//  CreateGoodHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//

import Foundation
import PerfectHTTP

class CreateGoodHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    let productDB: ProductDBService

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
        self.productDB = ProductDBService()
    }
}

extension CreateGoodHandler {

    func process() {
        switch validate() {
        case .success(let data):
            do {
                let product = try productDB.save(with: data)
                try sendingResponse(with: product)
            } catch {
                ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        }
    }

    enum ValidateResult {
        case success(ProductData)
        case badData
    }
    
    private func validate() -> ValidateResult {
        guard let title = request.param(name: "title"),
            let priceStr = request.param(name: "price"),
            let price = Decimal(string: priceStr) else {
                return .badData
        }
        return .success(ProductData(title: title, price: price, description: request.param(name: "description")))
    }
    
    private func sendingResponse(with product: Product) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(product: product))
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let product: Product
    }
    
}
