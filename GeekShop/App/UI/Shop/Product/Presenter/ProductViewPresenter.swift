//
//  ProductViewPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

protocol ProductController: class {
    func showProduct(with product: Product)
    func showReviews(with viewModels: [ProductReviewViewModel])
    func showError(_ error: Error)
}

protocol ProductPresenter: class {
    func loadProduct()
    func loadReviews()
}

class ProductViewPresenter {
    
    public weak var controller: ProductController!
    public var requestFactory: ShopRequestFactory!
    public var viewModelFactory: ProductReviewViewModelFactory!
    private var reviews: [ProductReview] = []
    public var product: Product!
    
}

extension ProductViewPresenter: ProductPresenter {
    
    func loadProduct() {
        self.controller.showProduct(with: self.product)
    }
    
    func loadReviews() {
        requestFactory.getReviews(for: product.id) { response in
            switch response.result {
            case .success(let result):
                self.reviews = result.reviews
                let viewModels = self.viewModelFactory.make(from: self.reviews)
                self.controller.showReviews(with: viewModels)
            case .failure(let error):
                self.controller.showError(error)
            }
        }
    }
    
}
