//
//  DeleteFromBasketHandler.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 14/05/2019.
//

import Foundation
import PerfectHTTP

class RemoveFromBasketHandler: AbstractHandler {
    var request: HTTPRequest
    var response: HTTPResponse
    
    let userDB: UserDBService
    let productDB: ProductDBService
    let basketProductDB: BasketProductDBService
    let basketDB: BasketDBService
    
    required init(request: HTTPRequest, response: HTTPResponse) {
        self.request = request
        self.response = response
        self.userDB = UserDBService()
        self.productDB = ProductDBService()
        self.basketProductDB = BasketProductDBService()
        self.basketDB = BasketDBService()
    }
}

extension RemoveFromBasketHandler {

    func process() {
        switch validate() {
        case .success(let data):
            do {
                let basket = try basketDB.remove(for: data.user, with: data.product)
                try sendingResponse(with: basket)
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
        case success(user: User, product: BasketProduct)
        case badData
        case userNotFound
        case productNotFound
    }
    
    private func validate() -> ValidateResult {
        guard let userIdStr = request.param(name: "user_id"),
            let userId = Int(userIdStr),
            let productIdStr = request.param(name: "product_id"),
            let productId = Int(productIdStr) else {
                return .badData
        }
        guard let user = try! userDB.load(id: userId) else {
            return .userNotFound
        }
        guard let product = try! productDB.load(id: productId) else {
            return .productNotFound
        }
        guard let basketProduct = try! basketProductDB.load(with: product) else {
            return .productNotFound
        }
        return .success(user: user, product: basketProduct)
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
