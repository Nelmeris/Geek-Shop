//
//  Review+CoreDataProperties.swift
//  
//
//  Created by Artem Kufaev on 14.02.2020.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var content: String?
    @NSManaged public var userId: User?
    @NSManaged public var productId: Product?

}
