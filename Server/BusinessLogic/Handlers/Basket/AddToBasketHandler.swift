//
//  AddToBasketHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 14/05/2019.
//

import Foundation
import PerfectHTTP

class AddToBasketHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
    }
}

extension AddToBasketHandler {

    func process() {
        switch validate() {
        case .success(let data):
            do {
                let context = CoreDataStack.shared.mainContext
                var basket: Basket! = Basket.fetchByUserId(Int(data.user.id), in: context)
                if basket == nil {
                    basket = Basket.make(for: data.user, in: context)
                }
                basket.addProduct(data.product, with: data.quantity, in: context)
                try sendingResponse(with: basket)
                CoreDataStack.shared.saveContext(context)
            } catch {
                ErrorHandler(request: request, response: response).process(with: error.localizedDescription)
            }
        case .badData:
            ErrorHandler(request: request, response: response).process(with: "Не полные данные")
        case .userNotFound:
            ErrorHandler(request: request, response: response).process(with: "Пользователь не найден")
        case .productNotFound:
            ErrorHandler(request: request, response: response).process(with: "Товар не найден")
        }
    }
    
    enum ValidateResult {
        case success(user: User, product: Product, quantity: Int)
        case badData
        case userNotFound, productNotFound
    }
    
    private func validate() -> ValidateResult {
        guard let userIdStr = request.param(name: "user_id"),
            let userId = Int(userIdStr),
            let productIdStr = request.param(name: "product_id"),
            let productId = Int(productIdStr),
            let quantityStr = request.param(name: "quantity"),
            let quantity = Int(quantityStr) else {
                return .badData
        }
        let context = CoreDataStack.shared.mainContext
        guard let user = User.fetchById(userId, in: context) else {
            return .userNotFound
        }
        guard let product = Product.fetchById(productId, in: context) else {
            return .productNotFound
        }
        return .success(user: user, product: product, quantity: quantity)
    }
    
    private func sendingResponse(with basket: Basket?) throws {
        self.response.setHeader(.contentType, value: "application/json")
        try self.response.setBody(json: Response(basket: basket))
        self.response.completed()
    }
    
    struct Response: Encodable {
        let result = 1
        let basket: Basket?
    }
    
}
