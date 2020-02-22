//
//  CatalogModelBuilder.swift
//  GeekShop
//
//  Created by Artem Kufaev on 18.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

class CatalogModelBuilder {
    
    static public func build() -> CatalogViewController {
        let vc = CatalogViewController()
        let presenter = CatalogViewPresenter()
        vc.presenter = presenter
        presenter.controller = vc
        presenter.requestFactory = RequestFactory().makeShopRequestFactory()
        presenter.viewModelFactory = ProductViewModelFactory()
        presenter.router = CatalogRouter(controller: vc)
        return vc
    }
    
}
