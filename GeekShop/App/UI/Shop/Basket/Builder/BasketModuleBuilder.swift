//
//  BasketModuleBuilder.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

class BasketModuleBuilder {
    
    static public func build() -> BasketController {
        let controller = BasketViewController()
        let presenter = BasketViewPresenter()
        controller.presenter = presenter
        presenter.controller = controller
        presenter.requestFactory = RequestFactory().makeBasketRequestFactory()
        presenter.viewModelFactory = BasketProductViewModelFactory()
        return controller
    }
    
}
