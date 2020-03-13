//
//  Product+CoreDataClass.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(descript, forKey: .description)
        try container.encode(price?.decimalValue, forKey: .price)
    }
    
}
