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
    let name: String
    let price: Int
    let quantity: Int

    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price
        case quantity
    }
}
