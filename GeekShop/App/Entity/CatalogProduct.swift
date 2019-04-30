//
//  CatalogProduct.swift
//  GeekShop
//
//  Created by Артем Куфаев on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct CatalogProduct: Codable {
    let id: Int
    let name: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price = "price"
    }
}
