//
//  Basket+CoreDataClass.swift
//  
//
//  Created by Artem Kufaev on 14.02.2020.
//
//

import Foundation
import CoreData

@objc(Basket)
public class Basket: NSManagedObject, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case user, products
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.user, forKey: .user)
        let products = self.products?.allObjects as! [BasketProduct]
        try container.encode(products, forKey: .products)
    }
    
}
