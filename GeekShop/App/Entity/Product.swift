//
//  Product.swift
//  GeekShop
//
//  Created by Артем Куфаев on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct Product: Codable {
    let result: Int
    let name: String
    let price: Int
    let description: String

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}
