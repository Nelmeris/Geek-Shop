//
//  RemoveReviewHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 30/04/2019.
//

import Foundation
import PerfectHTTP

class RemoveReviewHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension RemoveReviewHandler {
    
    func process() {
        switch validate() {
        case .success(let data):
            let context = CoreDataStack.shared.mainContext
            guard let review = Review.fetchById(data, in: context) else {
                ErrorHandler(request: request, response: response).process(with: "Отзыв не найден")
                return
            }
            context.delete(review)
            do {
                try sendingResponse()
            } catch {
                ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        }
    }
    
    enum ValidateResult {
        case success(reviewId: Int)
        case badData
    }
    
    private func validate() -> ValidateResult {
        guard let reviewIdStr = request.param(name: "review_id"),
            let reviewId = Int(reviewIdStr) else {
                return .badData
        }
        return .success(reviewId: reviewId)
    }
    
    private func sendingResponse() throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response())
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let userMessage = "Отзыв успешно удален"
    }

}
