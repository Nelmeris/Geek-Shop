//
//  Review+CoreDataClass.swift
//  
//
//  Created by Artem Kufaev on 14.02.2020.
//
//

import Foundation
import CoreData

@objc(Review)
public class Review: NSManagedObject, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case id, content, author, product, creationDate
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(author, forKey: .author)
        try container.encode(product, forKey: .product)
        try container.encode(creationDate, forKey: .creationDate)
    }
    
    static func fetchAll(in context: NSManagedObjectContext) -> [Review] {
        let request = NSFetchRequest<Review>(entityName: "Review")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            return try context.fetch(request)
        } catch {
            debugPrint("Can't fetch reviews")
            debugPrint((error as NSError).userInfo)
            return []
        }
    }
    
    static func fetchById(_ id: Int, in context: NSManagedObjectContext) -> Review? {
        let request = NSFetchRequest<Review>(entityName: "Review")
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            return try context.fetch(request).first
        } catch {
            debugPrint("Can't fetch review with id \(id)")
            debugPrint((error as NSError).userInfo)
            return nil
        }
    }
    
    static func fetchByProductId(_ id: Int, in context: NSManagedObjectContext) -> [Review]? {
        let request = NSFetchRequest<Review>(entityName: "Review")
        do {
            let reviews = try context.fetch(request)
            return reviews.filter { $0.product?.id == Int64(id) }
        } catch {
            debugPrint("Can't fetch review with id \(id)")
            debugPrint((error as NSError).userInfo)
            return nil
        }
    }
    
    static func make(with data: ReviewData, in context: NSManagedObjectContext) throws -> Review {
        let review = Review(context: context)
        let reviews = fetchAll(in: context)
        review.update(from: data)
        review.id = (reviews.last?.id ?? -1) + 1
        review.creationDate = Date()
        return review
    }
    
    func update(from data: ReviewData) {
        self.content = data.content
        self.author = data.user
        self.product = data.product
    }
    
}
