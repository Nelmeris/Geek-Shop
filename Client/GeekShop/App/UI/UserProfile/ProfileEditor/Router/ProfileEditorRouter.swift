//
//  ProfileEditorRouter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 15.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

class ProfileEditorRouter: BaseRouter {
    
    func toAuth() {
        self.controller.dismiss(animated: true)
    }
    
}
