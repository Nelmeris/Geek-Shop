//
//  LoginRouter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

final class LoginRouter: BaseRouter {
    
    func toProfile() {
        let controller = TabBarController()
        controller.modalPresentationStyle = .fullScreen
        self.controller.present(controller, animated: true)
    }
    
}
