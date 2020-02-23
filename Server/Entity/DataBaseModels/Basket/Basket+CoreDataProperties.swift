//
//  Basket+CoreDataProperties.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 23.02.2020.
//
//

import Foundation
import CoreData


extension Basket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Basket> {
        return NSFetchRequest<Basket>(entityName: "Basket")
    }

    @NSManaged public var user: User?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Basket {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: BasketProduct)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: BasketProduct)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
