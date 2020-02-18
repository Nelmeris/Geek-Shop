//
//  Review+CoreDataClass.swift
//  
//
//  Created by Artem Kufaev on 14.02.2020.
//
//

import Foundation
import CoreData

@objc(Review)
public class Review: NSManagedObject, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case id, content, user, product, creationDate
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(user, forKey: .user)
        try container.encode(product, forKey: .product)
        try container.encode(creationDate, forKey: .creationDate)
    }
    
}
