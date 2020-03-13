//
//  ProductModuleBuilder.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

class ProductModuleBuilder {
    
    public static func build(with product: Product) -> ProductViewController {
        let controller = ProductViewController()
        let presenter = ProductViewPresenter()
        controller.presenter = presenter
        presenter.viewModelFactory = ProductReviewViewModelFactory()
        let requestFactory = RequestFactory()
        presenter.shopRequestFactory = requestFactory.makeShopRequestFactory()
        presenter.basketRequestFactory = requestFactory.makeBasketRequestFactory()
        presenter.controller = controller
        presenter.product = product
        return controller
    }
    
}
