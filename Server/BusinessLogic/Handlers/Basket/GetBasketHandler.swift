//
//  GetBasketHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 14/05/2019.
//

import Foundation
import PerfectHTTP

class GetBasketHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension GetBasketHandler {

    func process() {
        switch validate() {
        case .success(let user):
            do {
                var basket: Basket! = Basket.fetchByUserId(Int(user.id), in: CoreDataStack.shared.mainContext)
                if basket == nil {
                    let context = CoreDataStack.shared.mainContext
                    basket = Basket.make(for: user, in: context)
                    CoreDataStack.shared.saveContext(context)
                }
                try sendingResponse(with: basket)
            } catch {
                ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        case .userNotFound:
            ErrorHandler(request: request, response: response).process(with: "Пользователь не найден")
        }
    }
    
    enum ValidateResult {
        case success(user: User)
        case badData
        case userNotFound
    }
    
    private func validate() -> ValidateResult {
        guard let userIdStr = request.param(name: "user_id"),
            let userId = Int(userIdStr) else {
                return .badData
        }
        let context = CoreDataStack.shared.mainContext
        guard let user = User.fetchById(userId, in: context) else {
            return .userNotFound
        }
        return .success(user: user)
    }
    
    private func sendingResponse(with basket: Basket) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(basket: basket))
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let basket: Basket
    }
    
}
