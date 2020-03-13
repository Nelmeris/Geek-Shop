//
//  ProductReview.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

struct ProductReview: Codable {
    let id: Int
    let author: User
    let product: Product
    let content: String
}
