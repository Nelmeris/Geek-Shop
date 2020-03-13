//
//  RegisterViewPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics
import FirebaseAnalytics

protocol RegisterController: class {
    func showResult(_ msg: String, completion: @escaping () -> ())
    func showError(_ error: Error)
}

protocol RegisterPresenter: class {
    func registerProcess(with model: RegisterInputModel)
}

class RegisterViewPresenter: RegisterPresenter {
    
    weak var controller: RegisterController!
    var auth: AuthRequestFactory!
    var router: RegisterRouter!
    
    func registerProcess(with model: RegisterInputModel) {
        guard validate(with: model) else { return }
        auth.register(username: model.username,
                      password: model.password,
                      name: model.name,
                      surname: model.surname,
                      email: model.email,
                      gender: model.gender,
                      creditCard: model.creditCard,
                      bio: model.bio) { response in
            switch response.result {
            case .success(let result):
                self.controller.showResult(result.message!) {
                    User.authUser = result.user
                    Analytics.logEvent("SignUp", parameters: [
                        "Success": true,
                        "User ID": result.user.id,
                        "Username": result.user.username
                    ])
                    self.router.toProfile()
                }
            case .failure(let error):
                Analytics.logEvent("SignUp", parameters: [
                    "success": false
                ])
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    private func validate(with model: RegisterInputModel) -> Bool {
        if model.username.isEmpty {
            self.controller.showResult("Напишите username") {}
            return false
        }
        if model.password.isEmpty {
            self.controller.showResult("Напишите пароль") {}
            return false
        }
        if model.password != model.repeatPassword {
            self.controller.showResult("Пароли не совпадают") {}
            return false
        }
        return true
    }
    
}
