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
    
    func process() {
        switch validate() {
        case .success(let data):
            do {
                let context = CoreDataStack.shared.mainContext
                let reviews = Review.fetchByProductId(data, in: context)
                try sendingResponse(with: reviews ?? [])
            } catch {
                ErrorHandler(request: request, response: response).process()
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        }
    }
    
    enum ValidateResult {
        case success(productId: Int)
        case badData
    }
    
    private func validate() -> ValidateResult {
        guard let productIdStr = request.param(name: "product_id"),
            let productId = Int(productIdStr) else {
                return .badData
        }
        return .success(productId: productId)
    }
    
    private func sendingResponse(with reviews: [Review]) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(reviews: reviews))
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let reviews: [Review]
    }
    
}
