//
//  Shop.swift
//  GeekShop
//
//  Created by Artem Kufaev on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

class Shop: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
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
    
    func getCatalogData(pageNumber: Int, categoryId: Int, completionHandler: @escaping (DataResponse<Array<CatalogProduct>>) -> Void) {
        let requestModel = CatalogRequest(baseUrl: baseUrl, pageNumber: pageNumber, categoryId: categoryId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getGoodById(productId: Int, completionHandler: @escaping (DataResponse<Product>) -> Void) {
        let requestModel = ProductRequest(baseUrl: baseUrl, id: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Shop {
    
    struct CatalogRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        
        let pageNumber: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": categoryId
            ]
        }
    }
    
    struct ProductRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        
        let id: Int
        
        var parameters: Parameters? {
            return [
                "id_product": id
            ]
        }
    }
    
}
