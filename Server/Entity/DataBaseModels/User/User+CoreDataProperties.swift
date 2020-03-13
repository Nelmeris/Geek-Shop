//
//  User+CoreDataProperties.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 23.02.2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var bio: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var creditCard: String?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var surname: String?
    @NSManaged public var username: String?
    @NSManaged public var basket: Basket?
    @NSManaged public var reviews: NSSet?

}

// MARK: Generated accessors for reviews
extension User {

    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: Review)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: Review)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}
