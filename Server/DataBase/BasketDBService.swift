//
//  BasketDBService.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 20.02.2020.
//

import Foundation
import CoreData

final class BasketDBService: BaseDBService {
    
    let entityName = "Basket"
    
    func load(for userId: Int) throws -> Basket {
        let request: NSFetchRequest<Basket> = NSFetchRequest(entityName: entityName)
        let baskets = try context.fetch(request)
        var basket: Basket! = baskets.first { $0.user?.id == Int64(userId) }
        if basket == nil {
            basket = Basket(context: context)
            basket.user = try UserDBService().load(id: userId)
            try saveContext()
        }
        return basket
    }
    
    func add(for user: User, with product: BasketProduct) throws -> Basket {
        var basket: Basket! = try load(for: Int(user.id))
        if basket == nil {
            basket = Basket(context: context)
            basket?.user = user
        }
        basket.addToProducts(product)
        try saveContext()
        return basket
    }
    
    func remove(for user: User, with product: BasketProduct) throws -> Basket {
        var basket: Basket! = try load(for: Int(user.id))
        if basket == nil {
            basket = Basket(context: context)
            basket?.user = user
        }
        basket.removeFromProducts(product)
        return basket
    }
    
    private func fillReview(_ basket: Basket, with data: BasketData) {
        basket.user = data.user
        basket.products = NSSet(array: data.products)
    }
    
}
