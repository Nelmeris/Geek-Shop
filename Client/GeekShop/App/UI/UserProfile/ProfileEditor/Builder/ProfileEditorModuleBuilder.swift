//
//  ProfileEditorModuleBuilder.swift
//  GeekShop
//
//  Created by Artem Kufaev on 15.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

class ProfileEditorModuleBuilder {
    
    static func build() -> ProfileEditorViewController {
        let controller = ProfileEditorViewController()
        guard let presenter = ProfileEditorViewPresenter() else { fatalError("Missing user data") }
        controller.presenter = presenter
        presenter.controller = controller
        presenter.router = ProfileEditorRouter(controller: controller)
        presenter.auth = RequestFactory().makeAuthRequestFatory()
        return controller
    }
    
}
