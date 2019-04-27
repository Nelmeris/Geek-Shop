//
//  ShopRequestFactory.swift
//  GeekShop
//
//  Created by Artem Kufaev on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol ShopRequestFactory {
    func getCatalogData(pageNumber: Int, categoryId: Int, completionHandler: @escaping (DataResponse<Array<CatalogProduct>>) -> Void)
    func getGoodById(productId: Int, completionHandler: @escaping (DataResponse<Product>) -> Void)
}
