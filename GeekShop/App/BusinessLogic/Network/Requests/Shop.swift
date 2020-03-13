//
//  Shop.swift
//  GeekShop
//
//  Created by Artem Kufaev on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol ShopRequestFactory {
    func getCatalog(pageNumber: Int, categoryId: Int, completion: @escaping (DataResponse<[CatalogProduct]>) -> ())
    func getGood(by id: Int, completion: @escaping (DataResponse<Product>) -> ())
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

    func getCatalog(pageNumber: Int, categoryId: Int, completion: @escaping (DataResponse<[CatalogProduct]>) -> ()) {
        let requestModel = CatalogRequest(baseUrl: baseUrl, pageNumber: pageNumber, categoryId: categoryId)
        self.request(request: requestModel, completionHandler: completion)
    }

    func getGood(by id: Int, completion: @escaping (DataResponse<Product>) -> ()) {
        let requestModel = ProductRequest(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completion)
    }
    
}

extension Shop {

    struct CatalogRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalog.get"

        let pageNumber: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "category_id": categoryId
            ]
        }
    }

    struct ProductRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalog.getGood"

        let id: Int

        var parameters: Parameters? {
            return [
                "product_id": id
            ]
        }
    }

}
