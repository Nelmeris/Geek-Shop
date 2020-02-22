//
//  ProductReviewViewModel.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

struct ProductReviewViewModel {
    let autherName: String
    let content: String
}

class ProductReviewViewModelFactory {
    
    public func make(from reviews: [ProductReview]) -> [ProductReviewViewModel] {
        return reviews.map(model)
    }
    
    private func model(from review: ProductReview) -> ProductReviewViewModel {
        let autherName = review.author.username
        let content = review.content
        return ProductReviewViewModel(autherName: autherName, content: content)
    }
    
}
