//
//  BasketProduct+CoreDataClass.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 20.02.2020.
//
//

import Foundation
import CoreData

@objc(BasketProduct)
public class BasketProduct: NSManagedObject, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case quantity, product
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.quantity, forKey: .quantity)
        try container.encode(self.product, forKey: .product)
    }
    
}
