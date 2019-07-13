//
//  Basket.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14/05/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

class Basket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    let baseUrl = URL(string: "http://127.0.0.1:8181/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Basket: BasketRequestFactory {
    
    func add(productId: Int, quantity: Int, completionHandler: @escaping (DataResponse<ResultResponse>) -> Void) {
        let requestModel = AddToBasketRequest(baseUrl: baseUrl, productId: productId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func remove(productId: Int, completionHandler: @escaping (DataResponse<ResultResponse>) -> Void) {
        let requestModel = RemoveFromBasketRequest(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func get(userId: Int, completionHandler: @escaping (DataResponse<GetBasketResponse>) -> Void) {
        let requestModel = GetBasketRequest(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Basket {
    
    struct AddToBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "basket.add"
        
        let productId: Int
        let quantity: Int
        var parameters: Parameters? {
            return [
                "id_product": productId,
                "quantity": quantity
            ]
        }
    }
    
    struct RemoveFromBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "basket.remove"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
    
    struct GetBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "basket.get"
        
        let userId: Int
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
    
}
