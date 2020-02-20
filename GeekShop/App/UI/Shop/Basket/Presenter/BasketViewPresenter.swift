//
//  BasketViewPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

protocol BasketController: UIViewController {
    func showProducts(with products: [BasketProductViewModel])
    func showError(_ error: Error)
}

protocol BasketPresenter: class {
    func loadProducts()
    func productDidRemove(with index: Int)
}

class BasketViewPresenter {
    
    weak var controller: BasketController!
    var requestFactory: BasketRequestFactory!
    var viewModelFactory: BasketProductViewModelFactory!
    var products: [BasketProduct] = []
    
}

extension BasketViewPresenter: BasketPresenter {
    
    func loadProducts() {
        requestFactory.get(userId: User.authUser!.id) { response in
            switch response.result {
            case .success(let result):
                self.products = result.contents
                let viewModels = self.viewModelFactory.make(with: self.products)
                self.controller.showProducts(with: viewModels)
            case .failure(let error):
                self.controller.showError(error)
            }
        }
    }
    
    func productDidRemove(with index: Int) {
        let product = products[index]
        requestFactory.remove(productId: product.id, userId: User.authUser!.id) { response in
            switch response.result {
            case .success:
                self.loadProducts()
            case .failure(let error):
                self.controller.showError(error)
            }
        }
    }
    
}
