//
//  Shop.swift
//  GeekShop
//
//  Created by Artem Kufaev on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol ShopRequestFactory {
    func getGoods(completion: @escaping (DataResponse<CatalogResponse>) -> ())
    func getReviews(for productId: Int, completion: @escaping (DataResponse<GetReviewsResponse>) -> ())
}

class Shop: AbstractRequestFactory {
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

extension Shop: ShopRequestFactory {
    
    func getGoods(completion: @escaping (DataResponse<CatalogResponse>) -> ()) {
        let requestModel = GetProductsRequest(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func getReviews(for productId: Int, completion: @escaping (DataResponse<GetReviewsResponse>) -> ()) {
        let requestModel = GetProductReviewsRequest(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completion)
    }
    
}

extension Shop {
    
    struct GetProductsRequest: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "product.get"
        
        var parameters: Parameters? { return [:] }
    }
    
    struct GetProductReviewsRequest: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "review.get"
        
        var productId: Int
        
        var parameters: Parameters? { return [
            "product_id": productId
            ]
        }
    }

}
