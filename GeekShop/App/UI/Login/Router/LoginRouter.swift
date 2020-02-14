//
//  LoginRouter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

final class LoginRouter: BaseRouter {
    
    func toProfile(_ user: User) {
        let vc = ProfileViewController(user: user)
        vc.modalPresentationStyle = .fullScreen
        self.controller.present(vc, animated: true)
    }
    
}
