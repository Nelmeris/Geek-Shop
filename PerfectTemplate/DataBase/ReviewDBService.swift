//
//  ReviewDBService.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//

import Foundation
import CoreData

final class ReviewDBService: BaseDBService {
    
    let entityName = "Review"
    
    func load() throws -> [Review] {
        let request: NSFetchRequest<Review> = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = [ NSSortDescriptor(key: "creationDate", ascending: true) ]
        return try context.fetch(request)
    }
    
    func load(for productId: Int) throws -> [Review] {
        let request: NSFetchRequest<Review> = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = [ NSSortDescriptor(key: "creationDate", ascending: true) ]
        let reviews = try context.fetch(request)
        return reviews.filter { $0.product?.id == Int64(productId) }
    }
    
    func load(for reviewId: Int) throws -> Review? {
        let request: NSFetchRequest<Review> = NSFetchRequest(entityName: entityName)
        let reviews = try context.fetch(request).filter { $0.id == Int64(reviewId) }
        return reviews.first
    }
    
    func save(with data: ReviewData) throws -> Review {
        let review = Review(context: context)
        let reviews = try load()
        review.id = (reviews.last?.id ?? -1) + 1
        fillReview(review, with: data)
        try saveContext()
        return review
    }
    
    func remove(with id: Int) throws -> Bool {
        let reviews = try load()
        for review in reviews {
            print(review.id)
        }
        guard let review = try load(for: id) else {
            return false
        }
        context.delete(review)
        return true
    }
    
    private func fillReview(_ review: Review, with data: ReviewData) {
        review.user = data.user
        review.product = data.product
        review.content = data.content
        review.creationDate = Date()
    }
    
}
