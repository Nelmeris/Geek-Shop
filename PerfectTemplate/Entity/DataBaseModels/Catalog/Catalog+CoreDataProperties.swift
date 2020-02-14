//
//  Catalog+CoreDataProperties.swift
//  
//
//  Created by Artem Kufaev on 14.02.2020.
//
//

import Foundation
import CoreData


extension Catalog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Catalog> {
        return NSFetchRequest<Catalog>(entityName: "Catalog")
    }

    @NSManaged public var id: Int64
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Catalog {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
