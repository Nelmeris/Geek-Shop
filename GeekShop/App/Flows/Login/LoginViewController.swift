//
//  LoginViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, AlertDelegate {
    
    private var auth: AuthRequestFactory!
    
    private var loginView: LoginView {
        return self.view as! LoginView
    }
    
    override func loadView() {
        super.loadView()
        self.view = LoginView(frame: self.view.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        self.loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        let requestFactory = RequestFactory()
        auth = requestFactory.makeAuthRequestFatory()
    }
    
    @objc func login() {
        guard let username = self.loginView.usernameField.text, !username.isEmpty,
            let password = self.loginView.passwordField.text, !password.isEmpty
            else { return }
        
        auth.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let response):
                self.showAlert(title: "Успешно! ID: \(response.user.id)")
            case .failure(let error):
                self.showAlert(title: error.localizedDescription)
            }
        }
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
}
