//
//  ProfileRouter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

final class ProfileRouter: BaseRouter {
    
    func toEditor() {
        let vc = ProfileEditorModuleBuilder.build()
        self.push(vc, animated: true)
    }
    
}
