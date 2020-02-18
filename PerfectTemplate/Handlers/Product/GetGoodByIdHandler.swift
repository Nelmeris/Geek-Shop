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
    let productDB: ProductDBService

    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
        self.productDB = ProductDBService()
    }
}

extension GetGoodByIdHandler {

    func process() {
        switch validate() {
        case .success(let data):
            do {
                try sendingResponse(with: data)
            } catch {
                ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        case .notFound:
            ErrorHandler(request: request, response: response).process(with: "Товар не найден")
        }
    }
    
    enum ValidateResult {
        case success(Product)
        case badData
        case notFound
    }
    
    private func validate() -> ValidateResult {
        guard let product_id = request.param(name: "product_id") else {
                return .badData
        }
        guard let product = try! productDB.load(id: product_id) else {
            return .notFound
        }
        return .success(product)
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
