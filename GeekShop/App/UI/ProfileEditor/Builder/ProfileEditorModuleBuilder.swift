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
        let vc = ProfileEditorViewController()
        guard let presenter = ProfileEditorViewPresenter() else { fatalError("Пользователь не найден") }
        vc.presenter = presenter
        presenter.controller = vc
        presenter.router = ProfileEditorRouter(controller: vc)
        presenter.auth = RequestFactory().makeAuthRequestFatory()
        return vc
    }
    
}
