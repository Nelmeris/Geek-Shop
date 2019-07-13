//
//  BasketRequestFactory.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14/05/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Alamofire

protocol BasketRequestFactory {
    func add(productId: Int, quantity: Int, completionHandler: @escaping (DataResponse<ResultResponse>) -> Void)
    func remove(productId: Int, completionHandler: @escaping (DataResponse<ResultResponse>) -> Void)
    func get(userId: Int, completionHandler: @escaping (DataResponse<GetBasketResponse>) -> Void)
}
