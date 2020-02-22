//
//  BasketProduct+CoreDataProperties.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 20.02.2020.
//
//

import Foundation
import CoreData


extension BasketProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasketProduct> {
        return NSFetchRequest<BasketProduct>(entityName: "BasketProduct")
    }

    @NSManaged public var quantity: Int64
    @NSManaged public var product: Product?
    @NSManaged public var basket: Basket?

}
