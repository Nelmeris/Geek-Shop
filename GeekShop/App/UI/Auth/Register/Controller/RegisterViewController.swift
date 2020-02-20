//
//  RegisterViewController.swift
//  GeekShop
//
//  Created by Артем Куфаев on 13/07/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit

struct RegisterInputModel {
    let username: String
    let name: String
    let surname: String
    let password: String
    let repeatPassword: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
}

class RegisterViewController: UIViewController, UITextFieldDelegate, AlertDelegate {
    
    // MARK: - Properties
    
    var presenter: RegisterPresenter!
    
    private var registerView: RegisterView {
        return self.view as! RegisterView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = RegisterView(frame: self.view.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        registerForKeyboardNotifications(with: self.registerView.registerFormView.scrollView)
        self.registerView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // MARK: - Actions
    
    @objc
    func register() {
        guard let username = self.registerView.registerFormView.usernameField.text,
            let name = self.registerView.registerFormView.nameField.text,
            let surname = self.registerView.registerFormView.surnameField.text,
            let password = self.registerView.registerFormView.passwordField.text,
            let repeatPassword = self.registerView.registerFormView.repeatPasswordField.text,
            let email = self.registerView.registerFormView.emailField.text,
            let gender = self.registerView.registerFormView.genderField.text,
            let creditCard = self.registerView.registerFormView.creditCardField.text,
            let bio = self.registerView.registerFormView.bioTextView.text
            else { fatalError("Ошибка введения данных") }
        
        let model = RegisterInputModel(username: username, name: name, surname: surname, password: password, repeatPassword: repeatPassword, email: email, gender: gender, creditCard: creditCard, bio: bio)
        
        presenter.registerProcess(with: model)
    }

}

extension RegisterViewController: RegisterController {
    
    func showResult(_ msg: String, completion: @escaping () -> () = {}) {
        self.showAlert(title: msg) { _ in
            completion()
        }
    }
    
    func showError(_ error: Error) {
        fatalError(error.localizedDescription)
    }
    
}
