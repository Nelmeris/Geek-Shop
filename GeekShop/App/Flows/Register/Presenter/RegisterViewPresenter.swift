//
//  RegisterViewPresenter.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

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
        auth.register(userName: model.username,
                      password: model.password,
                      email: model.email,
                      gender: model.gender,
                      creditCard: model.creditCard,
                      bio: model.bio) { response in
            switch response.result {
            case .success(let result):
                self.controller.showResult(result.userMessage) {
                    let user = User(id: 0, login: model.username, name: model.name, lastname: model.surname)
                    self.router.toProfile(user)
                }
            case .failure(let error):
                self.controller.showError(error)
            }
        }
    }
    
    private func validate(with model: RegisterInputModel) -> Bool {
        if model.username.isEmpty {
            self.controller.showResult("Напишите username") {}
            return false
        }
        if model.name.isEmpty {
            self.controller.showResult("Напишите имя") {}
            return false
        }
        if model.surname.isEmpty {
            self.controller.showResult("Напишите фамилию") {}
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
        if model.email.isEmpty {
            self.controller.showResult("Напишите почту") {}
            return false
        }
        if model.creditCard.isEmpty {
            self.controller.showResult("Напишите кредитную карту") {}
            return false
        }
        return true
    }
    
}
