//
//  RegisterViewController.swift
//  GeekShop
//
//  Created by Артем Куфаев on 13/07/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, AlertDelegate {
    
    // MARK: - Properties
    
    private lazy var auth: AuthRequestFactory! = {
        let requestFactory = RequestFactory()
        return requestFactory.makeAuthRequestFatory()
    }()
    
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
        guard let username = self.registerView.usernameField.text, !username.isEmpty,
            let password = self.registerView.passwordField.text, !password.isEmpty,
            password == self.registerView.repeatPasswordField.text,
            let email = self.registerView.emailField.text, !email.isEmpty,
            let gender = self.registerView.genderField.text, !gender.isEmpty,
            let creditCard = self.registerView.creditCardField.text, !creditCard.isEmpty,
            let bio = self.registerView.bioTextView.text
            else { return }
        
        auth.register(userName: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
            switch response.result {
            case .success(let response):
                self.showAlert(title: response.userMessage)
            case .failure(let error):
                self.showAlert(title: error.localizedDescription)
            }
        }
    }

}
