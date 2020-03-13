//
//  ProductViewModel.swift
//  GeekShop
//
//  Created by Artem Kufaev on 18.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

struct ProductViewModel {
    let title: String
    let price: String
    let description: String?
}

class ProductViewModelFactory {
    
    public func make(from products: [Product]) -> [ProductViewModel] {
        return products.map(model)
    }
    
    private func model(from product: Product) -> ProductViewModel {
        let title = product.title
        let price = NSDecimalNumber(decimal: product.price).stringValue
        let description = product.description
        return ProductViewModel(title: title, price: price, description: description)
    }
    
}
