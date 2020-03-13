//
//  RegisterModuleBuilder.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

final class RegisterModuleBuilder {
    
    static func build() -> (UIViewController & RegisterController) {
        let presenter = RegisterViewPresenter()
        let viewController = RegisterViewController()
        let router = RegisterRouter(controller: viewController)
        let auth = RequestFactory().makeAuthRequestFatory()
        viewController.presenter = presenter
        presenter.router = router
        presenter.auth = auth
        presenter.controller = viewController
        return viewController
    }
    
}
