//
//  GetBasketResponse.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14/05/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct GetBasketResponse: Codable {
    let amount: Int
    let countGoods: Int
    let contents: [BasketProduct]
    
    enum CodingKeys: String, CodingKey {
        case amount
        case countGoods = "count_goods"
        case contents
    }
}
