//
//  Product.swift
//  GeekShop
//
//  Created by Артем Куфаев on 26/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Decimal
    let description: String?
}
