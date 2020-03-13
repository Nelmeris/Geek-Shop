//
//  CatalogViewPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 18.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

protocol CatalogController: class {
    func showProducts(_ viewModels: [ProductViewModel])
    func showError(_ error: Error)
}

protocol CatalogPresenter: class {
    func loadProducts()
}

class CatalogViewPresenter: CatalogPresenter {
    
    private let shop = RequestFactory().makeShopRequestFactory()
    private let viewModelFactory = ProductViewModelFactory()
    
    weak var controller: CatalogController!
    
    func loadProducts() {
        shop.getGoods { response in
            switch response.result {
            case .success(let result):
                let viewModels = self.viewModelFactory.make(from: result.products)
                self.controller.showProducts(viewModels)
            case .failure(let error):
                self.controller.showError(error)
            }
        }
    }
    
}
