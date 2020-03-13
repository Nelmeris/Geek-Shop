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
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension AddReviewHandler {
    
    func process() {
        switch validate() {
        case .success(let data):
            do {
                let context = CoreDataStack.shared.mainContext
                let review = try Review.make(with: data, in: context)
                try sendingResponse(with: review)
                CoreDataStack.shared.saveContext(context)
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
            let userIdStr = request.param(name: "user_id"),
            let userId = Int(userIdStr),
            let productIdStr = request.param(name: "product_id"),
            let productId = Int(productIdStr) else {
                return .badData
        }
        let context = CoreDataStack.shared.mainContext
        guard let user = User.fetchById(userId, in: context) else {
            return .userNotFound
        }
        guard let product = Product.fetchById(productId, in: context) else {
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
