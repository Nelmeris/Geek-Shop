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
        registerForKeyboardNotifications(with: self.registerView.scrollView)
        self.registerView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // MARK: - Actions
    
    @objc func register() {
        guard let username = self.registerView.usernameField.text,
            let name = self.registerView.nameField.text,
            let surname = self.registerView.surnameField.text,
            let password = self.registerView.passwordField.text,
            let repeatPassword = self.registerView.repeatPasswordField.text,
            let email = self.registerView.emailField.text,
            let gender = self.registerView.genderField.text,
            let creditCard = self.registerView.creditCardField.text,
            let bio = self.registerView.bioTextView.text
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
