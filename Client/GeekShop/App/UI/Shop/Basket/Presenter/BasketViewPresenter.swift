//
//  BasketViewPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics
import FirebaseAnalytics

protocol BasketController: UIViewController {
    func showProducts(with products: [BasketProductViewModel])
    func showMessage(_ message: String)
    func showError(_ error: Error)
}

protocol BasketPresenter: class {
    func loadProducts()
    func productDidChangeQuantity(for index: Int, with quantity: Int)
    func productDidRemove(with index: Int)
    func makePurchase()
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
                self.products = result.basket.products
                let viewModels = self.viewModelFactory.make(with: self.products)
                self.controller.showProducts(with: viewModels)
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    func productDidRemove(with index: Int) {
        let product = products[index]
        requestFactory.remove(productId: product.product.id, userId: User.authUser!.id) { response in
            switch response.result {
            case .success:
                AnalyticInvoker.shared.add(.removeFromCart(product: product.product))
                self.loadProducts()
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    func productDidChangeQuantity(for index: Int, with quantity: Int) {
        let product = products[index]
        requestFactory.add(productId: product.product.id, userId: User.authUser!.id, quantity: quantity) { response in
            switch response.result {
            case .success:
                AnalyticInvoker.shared.add(.addToCart(product: product.product, quantity: quantity, currency: .rubles))
                self.loadProducts()
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    func makePurchase() {
        // TODO
        AnalyticInvoker.shared.add(.purchase(totalPrice: 0.0, currency: .rubles))
        let message = R.string.localizable.purchaseIsMadeMessage()
        self.controller.showMessage(message)
    }
    
}
