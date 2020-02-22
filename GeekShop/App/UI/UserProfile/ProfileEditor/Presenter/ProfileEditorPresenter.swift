//
//  ProfileEditorPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 15.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics
import FirebaseAnalytics

protocol ProfileEditorController: class {
    func showResult(_ msg: String, completion: @escaping () -> ())
    func showError(_ error: Error)
}

protocol ProfileEditorPresenter: class {
    func changeDataProcess(with model: RegisterInputModel)
    func logoutProcess()
}

class ProfileEditorViewPresenter: ProfileEditorPresenter {
    
    weak var controller: ProfileEditorController!
    var auth: AuthRequestFactory!
    var router: ProfileEditorRouter!
    private var user: User!
    
    init?() {
        self.user = User.authUser
    }
    
    func changeDataProcess(with model: RegisterInputModel) {
        guard validate(with: model) else { return }
        auth.changeUserData(id: self.user.id, username: model.username, password: model.password, name: model.name, surname: model.surname, email: model.email, gender: model.gender, creditCard: model.creditCard, bio: model.bio) { response in
            switch response.result {
            case .success(let result):
                self.controller.showResult(result.message!) {}
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    func logoutProcess() {
        auth.logout(id: self.user.id) { response in
            switch response.result {
            case .success:
                Analytics.logEvent("Logout", parameters: [
                    "User ID": self.user.id,
                    "Username": self.user.username
                ])
                let message = R.string.localizable.successfulMessage()
                self.controller.showResult(message) {
                    User.authUser = nil
                    DispatchQueue.main.async {
                        self.router.toAuth()
                    }
                }
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                self.controller.showError(error)
            }
        }
    }
    
    private func validate(with model: RegisterInputModel) -> Bool {
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
