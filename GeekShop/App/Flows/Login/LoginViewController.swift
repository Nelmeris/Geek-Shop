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
    
    // MARK: - Properties
    
    private lazy var router: LoginRouter = { return LoginRouter(controller: self) }()
    
    private lazy var auth: AuthRequestFactory! = {
        let requestFactory = RequestFactory()
        return requestFactory.makeAuthRequestFatory()
    }()
    
    private var loginView: LoginView {
        return self.view as! LoginView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = LoginView(frame: self.view.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        self.loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // MARK: - Actions
    
    @objc func login() {
        guard let username = self.loginView.usernameField.text, !username.isEmpty,
            let password = self.loginView.passwordField.text, !password.isEmpty
            else { return }
        
        auth.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let response):
                self.showAlert(title: "Успешно! ID: \(response.user.id)") { _ in
                    self.router.toProfile(response.user)
                }
            case .failure(let error):
                self.showAlert(title: error.localizedDescription)
            }
        }
    }
    
}
