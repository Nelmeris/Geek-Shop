//
//  CatalogResponse.swift
//  GeekShop
//
//  Created by Artem Kufaev on 18.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

struct CatalogResponse: Codable {
    let result: Int
    let message: String?
    let products: [Product]
}
