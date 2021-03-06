//
//  Basket.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14/05/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol BasketRequestFactory {
    func add(productId: Int, userId: Int, quantity: Int, completion: @escaping (DataResponse<ResultResponse>) -> Void)
    func remove(productId: Int, userId: Int, completion: @escaping (DataResponse<ResultResponse>) -> Void)
    func get(userId: Int, completion: @escaping (DataResponse<GetBasketResponse>) -> Void)
}

class BasketService: AbstractRequestFactory {
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

extension BasketService: BasketRequestFactory {
    
    func add(productId: Int, userId: Int, quantity: Int, completion: @escaping (DataResponse<ResultResponse>) -> Void) {
        let requestModel = AddToBasketRequest(baseUrl: baseUrl, productId: productId, quantity: quantity, userId: userId)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func remove(productId: Int, userId: Int, completion: @escaping (DataResponse<ResultResponse>) -> Void) {
        let requestModel = RemoveFromBasketRequest(baseUrl: baseUrl, productId: productId, userId: userId)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func get(userId: Int, completion: @escaping (DataResponse<GetBasketResponse>) -> Void) {
        let requestModel = GetBasketRequest(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completion)
    }
    
}

extension BasketService {
    
    struct AddToBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "basket.add"
        
        let productId: Int
        let quantity: Int
        let userId: Int
        
        var parameters: Parameters? {
            return [
                "product_id": productId,
                "quantity": quantity,
                "user_id": userId
            ]
        }
    }
    
    struct RemoveFromBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "basket.remove"
        
        let productId: Int
        let userId: Int
        var parameters: Parameters? {
            return [
                "product_id": productId,
                "user_id": userId
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
                "user_id": userId
            ]
        }
    }
    
}
