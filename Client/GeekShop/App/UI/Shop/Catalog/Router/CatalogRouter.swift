//
//  CatalogRouter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

final class CatalogRouter: BaseRouter {
    
    public func toProduct(with product: Product) {
        let controller = ProductModuleBuilder.build(with: product)
        self.push(controller, animated: true)
    }
    
}
