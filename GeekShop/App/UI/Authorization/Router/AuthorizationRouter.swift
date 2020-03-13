//
//  AuthorizationRouter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

final class AuthorizationRouter: BaseRouter {
    
    func toLogin() {
        let loginVC = LoginViewController()
        self.push(loginVC, animated: true)
    }
    
    func toRegister() {
        let registerVC = RegisterModuleBuilder.build()
        self.push(registerVC, animated: true)
    }
    
}
