//
//  AnalyticCommand.swift
//  GeekShop
//
//  Created by Artem Kufaev on 22.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

enum AnalyticCommand {
    
    case login(isSuccess: Bool)
    case signUp(isSuccess: Bool)
    case logout
    
    case openCatalog
    case openProductPage(product: Product)
    
    case addToCart(product: Product, quantity: Int, currency: Currency)
    case removeFromCart(product: Product)
    case purchase(totalPrice: Decimal, currency: Currency)
    
    var event: AnalyticEvent {
        switch self {
        case .login(let isSuccess):
            return AnalyticEvent(name: "login", parameters: [
                "Success": isSuccess ? "Yes" : "No"
            ])
        case .signUp(let isSuccess):
            return AnalyticEvent(name: "sign_up", parameters: [
                "Success": isSuccess ? "Yes" : "No"
            ])
        case .openCatalog:
            return AnalyticEvent(name: "open_catalog", parameters: [:])
        case .openProductPage(let product):
            return AnalyticEvent(name: "open_product_page", parameters: [
                "Product ID": product.id,
                "Product name": product.title
            ])
        case .addToCart(let product, let quantity, let currency):
            return AnalyticEvent(name: "add_to_cart", parameters: [
                "Product ID": product.id,
                "Product name": product.title,
                "Price": product.price,
                "Quantity": quantity,
                "Currency": currency.rawValue
            ])
        case .logout:
            return AnalyticEvent(name: "logout", parameters: [:])
        case .purchase(let totalPrice, let currency):
            return AnalyticEvent(name: "purchase", parameters: [
                "Total price": totalPrice,
                "Currency": currency.rawValue
            ])
        case .removeFromCart(let product):
            return AnalyticEvent(name: "remove_from_cart", parameters: [
                "Product ID": product.id,
                "Product name": product.title
            ])
        }
    }
    
}
