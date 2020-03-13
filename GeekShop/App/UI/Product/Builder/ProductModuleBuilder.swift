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
        let vc = ProductViewController()
        let presenter = ProductViewPresenter()
        vc.presenter = presenter
        presenter.viewModelFactory = ProductReviewViewModelFactory()
        presenter.requestFactory = RequestFactory().makeShopRequestFactory()
        presenter.controller = vc
        presenter.product = product
        return vc
    }
    
}
