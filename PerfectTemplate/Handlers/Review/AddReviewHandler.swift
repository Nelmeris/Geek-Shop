//
//  AddReviewHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 30/04/2019.
//

import Foundation
import PerfectHTTP

class AddReviewHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    let reviewDB: ReviewDBService
    let userDB: UserDBService
    let productDB: ProductDBService
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
        self.reviewDB = ReviewDBService()
        self.userDB = UserDBService()
        self.productDB = ProductDBService()
    }
}

extension AddReviewHandler {
    
    func process() {
        switch validate() {
        case .success(let data):
            do {
                let review = try reviewDB.save(with: data)
                try sendingResponse(with: review)
            } catch {
                ErrorHandler(request: request, response: response).process()
            }
        case .userNotFound:
            ErrorHandler(request: request, response: response).process(with: "Пользователь не найден")
        case .productNotFound:
            ErrorHandler(request: request, response: response).process(with: "Товар не найден")
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        }
    }
    
    enum ValidateResult {
        case success(ReviewData)
        case badData
        case productNotFound
        case userNotFound
    }
    
    private func validate() -> ValidateResult {
        guard let content = request.param(name: "content"),
            let userId = request.param(name: "user_id"),
            let productId = request.param(name: "product_id") else {
                return .badData
        }
        guard let user = try! userDB.load(id: userId) else {
            return .userNotFound
        }
        guard let product = try! productDB.load(id: productId) else {
            return .productNotFound
        }
        return .success(ReviewData(content: content, user: user, product: product))
    }
    
    private func sendingResponse(with review: Review) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(review: review))
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let userMessage = "Ваш отзыв был передан на модерацию!"
        let review: Review
    }
    
}
