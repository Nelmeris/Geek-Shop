//
//  Product+CoreDataProperties.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 23.02.2020.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var descript: String?
    @NSManaged public var id: Int64
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var title: String?
    @NSManaged public var reviews: NSSet?
    @NSManaged public var basketProduct: NSSet?

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

// MARK: Generated accessors for basketProduct
extension Product {

    @objc(addBasketProductObject:)
    @NSManaged public func addToBasketProduct(_ value: BasketProduct)

    @objc(removeBasketProductObject:)
    @NSManaged public func removeFromBasketProduct(_ value: BasketProduct)

    @objc(addBasketProduct:)
    @NSManaged public func addToBasketProduct(_ values: NSSet)

    @objc(removeBasketProduct:)
    @NSManaged public func removeFromBasketProduct(_ values: NSSet)

}
