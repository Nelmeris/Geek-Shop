//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Artem Kufaev on 14.02.2020.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var descript: String?
    @NSManaged public var id: Int64
    @NSManaged public var basket: NSSet?
    @NSManaged public var reviews: NSSet?
    @NSManaged public var catalog: NSSet?

}

// MARK: Generated accessors for basket
extension Product {

    @objc(addBasketObject:)
    @NSManaged public func addToBasket(_ value: Basket)

    @objc(removeBasketObject:)
    @NSManaged public func removeFromBasket(_ value: Basket)

    @objc(addBasket:)
    @NSManaged public func addToBasket(_ values: NSSet)

    @objc(removeBasket:)
    @NSManaged public func removeFromBasket(_ values: NSSet)

}

// MARK: Generated accessors for reviews
extension Product {

    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: Review)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: Review)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}

// MARK: Generated accessors for catalog
extension Product {

    @objc(addCatalogObject:)
    @NSManaged public func addToCatalog(_ value: Catalog)

    @objc(removeCatalogObject:)
    @NSManaged public func removeFromCatalog(_ value: Catalog)

    @objc(addCatalog:)
    @NSManaged public func addToCatalog(_ values: NSSet)

    @objc(removeCatalog:)
    @NSManaged public func removeFromCatalog(_ values: NSSet)

}
