//
//  ProductData.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//

import Foundation

struct ProductData: Codable {
    let title: String
    let price: Decimal
    let description: String?
}
