//
//  BasketProductViewModel.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

struct BasketProductViewModel: Equatable {
    let title: String
    let price: String
    let quantity: String
}

class BasketProductViewModelFactory {
    
    public func make(with products: [BasketProduct]) -> [BasketProductViewModel] {
        return products.map(model)
    }
    
    private func model(with product: BasketProduct) -> BasketProductViewModel {
        let price = NSDecimalNumber(decimal: product.product.price).stringValue
        let title = product.product.title
        let quantity = String(product.quantity)
        return BasketProductViewModel(title: title, price: price, quantity: quantity)
    }
    
}
