//
//  CatalogViewPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 18.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Crashlytics

protocol CatalogController: class {
    func showProducts(_ viewModels: [ProductViewModel])
    func showError(_ error: Error)
}

protocol CatalogPresenter: class {
    func loadProducts()
    func productDidSelect(for indexPath: IndexPath)
}

class CatalogViewPresenter: CatalogPresenter {
    
    public var requestFactory: ShopRequestFactory!
    public var viewModelFactory: ProductViewModelFactory!
    public var router: CatalogRouter!
    
    private var products: [Product] = []
    
    weak var controller: CatalogController!
    
    func loadProducts() {
        requestFactory.getGoods { response in
            switch response.result {
            case .success(let result):
                self.products = result.products
                let viewModels = self.viewModelFactory.make(from: result.products)
                self.controller.showProducts(viewModels)
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    func productDidSelect(for indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        self.router.toProduct(with: product)
    }
    
}
