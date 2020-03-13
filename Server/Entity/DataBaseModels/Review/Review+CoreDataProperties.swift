//
//  Review+CoreDataProperties.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 23.02.2020.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var content: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var id: Int64
    @NSManaged public var author: User?
    @NSManaged public var product: Product?

}
