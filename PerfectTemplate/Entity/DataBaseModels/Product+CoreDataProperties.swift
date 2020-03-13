//
//  Product+CoreDataProperties.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
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
    @NSManaged public var basket: NSSet?
    @NSManaged public var reviews: NSSet?
    @NSManaged public var basketProducts: NSSet?

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

// MARK: Generated accessors for basketProducts
extension Product {

    @objc(addBasketProductsObject:)
    @NSManaged public func addToReviews(_ value: BasketProduct)

    @objc(removeBasketProductsObject:)
    @NSManaged public func removeFromReviews(_ value: BasketProduct)

    @objc(addToBasketProducts:)
    @NSManaged public func addToBasketProducts(_ values: NSSet)

    @objc(removeFromBasketProducts:)
    @NSManaged public func removeFromBasketProducts(_ values: NSSet)
    
}
