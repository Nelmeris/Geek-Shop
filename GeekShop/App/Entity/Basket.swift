//
//  Basket.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

struct Basket: Codable {
    let user: User
    let products: [BasketProduct]
}
