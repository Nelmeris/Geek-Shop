//
//  ProductViewPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Crashlytics
import FirebaseAnalytics

protocol ProductController: class {
    func showProduct(with product: Product)
    func showReviews(with viewModels: [ProductReviewViewModel])
    func showMessage(_ message: String)
    func showError(_ error: Error)
}

protocol ProductPresenter: class {
    func loadProduct()
    func loadReviews()
    func addToBasket()
}

class ProductViewPresenter {
    
    public weak var controller: ProductController!
    public var shopRequestFactory: ShopRequestFactory!
    public var basketRequestFactory: BasketRequestFactory!
    public var viewModelFactory: ProductReviewViewModelFactory!
    private var reviews: [ProductReview] = []
    public var product: Product!
    
}

extension ProductViewPresenter: ProductPresenter {
    
    func loadProduct() {
        self.controller.showProduct(with: self.product)
        Analytics.logEvent("OpenProductPage", parameters: [
            "Product ID": product.id,
            "Product name": product.title
        ])
    }
    
    func loadReviews() {
        shopRequestFactory.getReviews(for: product.id) { response in
            switch response.result {
            case .success(let result):
                self.reviews = result.reviews
                let viewModels = self.viewModelFactory.make(from: self.reviews)
                self.controller.showReviews(with: viewModels)
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    func addToBasket() {
        basketRequestFactory.add(productId: self.product.id, userId: User.authUser!.id, quantity: 1) { response in
            switch response.result {
            case .success:
                Analytics.logEvent("AddToCart", parameters: [
                    "Product ID": self.product.id,
                    "Product name": self.product.title,
                    "Price": self.product.price,
                    "Quantity": 1,
                    "Currency": "RUB"
                ])
                let message = R.string.localizable.successfulAddToCartMessage()
                self.controller.showMessage(message)
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
}
