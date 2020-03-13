//
//  ProductDBService.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//

import Foundation
import CoreData

final class ProductDBService: BaseDBService {
    
    let entityName = "Product"
    
    func load() throws -> [Product] {
        let request: NSFetchRequest<Product> = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = [ NSSortDescriptor(key: "id", ascending: true) ]
        return try context.fetch(request)
    }
    
    func load(id: String) throws -> Product? {
        let request: NSFetchRequest<Product> = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %@", id)
        return try context.fetch(request).first
    }
    
    func save(with data: ProductData) throws -> Product {
        let product = Product(context: context)
        let products = try self.load()
        product.id = (products.last?.id ?? -1) + 1
        fillProduct(product, with: data)
        try saveContext()
        return product
    }
    
    private func fillProduct(_ product: Product, with data: ProductData) {
        product.title = data.title
        product.price = NSDecimalNumber(decimal: data.price)
        product.descript = data.description
    }
    
}
