//
//  Basket+CoreDataClass.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 22.02.2020.
//
//

import Foundation
import CoreData

@objc(Basket)
public class Basket: NSManagedObject, Encodable {

    enum CodingKeys: String, CodingKey {
        case user, products
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user, forKey: .user)
        try container.encode(products?.allObjects as! [BasketProduct], forKey: .products)
    }
    
    static func fetchByUserId(_ id: Int, in context: NSManagedObjectContext) -> Basket? {
        let request = NSFetchRequest<Basket>(entityName: "Basket")
        do {
            let baskets = try context.fetch(request)
            return baskets.first { $0.user?.id == Int64(id) }
        } catch {
            debugPrint("Can't fetch basket for user with id \(id)")
            debugPrint((error as NSError).userInfo)
            return nil
        }
    }
    
    func addProduct(_ product: Product, with quanity: Int, in context: NSManagedObjectContext) {
        var basketProduct: BasketProduct! = BasketProduct.fetchAll(in: context).first { $0.product == product }
        if basketProduct == nil {
            basketProduct = BasketProduct(context: context)
            basketProduct.product = product
            self.addToProducts(basketProduct)
        }
        basketProduct.quantity = Int16(quanity)
    }
    
    func removeProduct(_ product: Product, in context: NSManagedObjectContext) {
        let basketProducts = self.products?.allObjects as! [BasketProduct]?
        guard let basketProduct = basketProducts?.first(where: { $0.product?.id == product.id }) else { return }
        context.delete(basketProduct)
    }
    
    static func make(for user: User, in context: NSManagedObjectContext) -> Basket {
        var basket: Basket! = Basket.fetchByUserId(Int(user.id), in: context)
        if basket == nil {
            basket = Basket(context: context)
            basket.user = user
            basket.products = []
        }
        return basket
    }

}
