//
//  BasketProductDBService.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 20.02.2020.
//

import Foundation
import CoreData

final class BasketProductDBService: BaseDBService {
    
    let entityName = "BasketProduct"
    
    func load() throws -> [BasketProduct] {
        let request: NSFetchRequest<BasketProduct> = NSFetchRequest(entityName: entityName)
        let products = try context.fetch(request)
        return products.sorted { $0.product!.id > $1.product!.id }
    }
    
    func load(with product: Product) throws -> BasketProduct? {
        let request: NSFetchRequest<BasketProduct> = NSFetchRequest(entityName: entityName)
        let products = try context.fetch(request)
        return products.first { $0.product?.id == product.id }
    }
    
    func save(with quantity: Int, product: Product) throws -> BasketProduct? {
        var basketProduct: BasketProduct? = try self.load().first { $0.product == product }
        guard quantity >= 1 else {
            if let basketProduct = basketProduct {
                context.delete(basketProduct)
            }
            return nil
        }
        if basketProduct == nil {
            basketProduct = BasketProduct(context: context)
        }
        basketProduct?.quantity = Int64(quantity)
        basketProduct?.product = product
        try saveContext()
        return basketProduct
    }
    
}
