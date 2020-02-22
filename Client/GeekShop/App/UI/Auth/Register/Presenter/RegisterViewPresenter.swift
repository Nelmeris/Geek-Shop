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
    func showResult(_ msg: String, completion: @escaping () -> Void)
    func showError(_ error: Error)
}

protocol RegisterPresenter: class {
    func registerProcess(with model: UserData)
}

class RegisterViewPresenter: RegisterPresenter {
    
    weak var controller: RegisterController!
    var auth: AuthRequestFactory!
    var router: RegisterRouter!
    
    func registerProcess(with model: UserData) {
        guard validate(with: model) else { return }
        auth.register(with: model) { response in
            switch response.result {
            case .success(let result):
                self.controller.showResult(result.message!) {
                    User.authUser = result.user
                    AnalyticInvoker.shared.add(.signUp(isSuccess: true))
                    self.router.toProfile()
                }
            case .failure(let error):
                AnalyticInvoker.shared.add(.signUp(isSuccess: false))
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    private func validate(with model: UserData) -> Bool {
        if model.username.isEmpty {
            let message = R.string.localizable.missingUsernameErrorMessage()
            self.controller.showResult(message) {}
            return false
        }
        if model.password.isEmpty {
            let message = R.string.localizable.missingPasswordErrorMessage()
            self.controller.showResult(message) {}
            return false
        }
        if model.password != model.repeatPassword {
            let message = R.string.localizable.passwordsDontMatch()
            self.controller.showResult(message) {}
            return false
        }
        return true
    }
    
}
