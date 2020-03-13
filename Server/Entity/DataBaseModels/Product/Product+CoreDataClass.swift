//
//  Product+CoreDataClass.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(descript, forKey: .description)
        try container.encode(price?.decimalValue, forKey: .price)
    }
    
    static func fetchAll(in context: NSManagedObjectContext) -> [Product] {
        let request = NSFetchRequest<Product>(entityName: "Product")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            return try context.fetch(request)
        } catch {
            debugPrint("Can't fetch product list")
            debugPrint((error as NSError).userInfo)
            return []
        }
    }
    
    static func fetchById(_ id: Int, in context: NSManagedObjectContext) -> Product? {
        let request = NSFetchRequest<Product>(entityName: "Product")
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            return try context.fetch(request).first
        } catch {
            debugPrint("Can't fetch product with id \(id)")
            debugPrint((error as NSError).userInfo)
            return nil
        }
    }
    
    static func update(for id: Int, from data: ProductData, in context: NSManagedObjectContext) throws -> Product? {
        guard let userById = Product.fetchById(id, in: context) else {
            return nil
        }
        userById.update(from: data)
        return userById
    }
    
    static func make(from data: ProductData, in context: NSManagedObjectContext) throws -> Product {
        let products = fetchAll(in: context)
        let product = Product(context: context)
        product.update(from: data)
        product.id = (products.last?.id ?? -1) + 1
        return product
    }
    
    func update(from data: ProductData) {
        self.title = data.title
        self.price = data.price as NSDecimalNumber
        self.descript = data.description
    }
    
}
