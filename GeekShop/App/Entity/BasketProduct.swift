//
//  BasketProduct.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14/05/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct BasketProduct: Codable {
    let id: Int
    let title: String
    let price: Decimal
    let quantity: Int
}
