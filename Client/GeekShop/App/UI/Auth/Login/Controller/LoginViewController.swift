//
//  LoginViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics
import FirebaseAnalytics

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var router: LoginRouter = { return LoginRouter(controller: self) }()
    
    private lazy var auth: AuthRequestFactory! = {
        let requestFactory = RequestFactory()
        return requestFactory.makeAuthRequestFatory()
    }()
    
    private var loginView: LoginView {
        guard let view = self.view as? LoginView else { fatalError() }
        return view
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
    
    @objc
    func login() {
        guard let username = self.loginView.usernameField.text, !username.isEmpty,
            let password = self.loginView.passwordField.text, !password.isEmpty
            else { return }
        
        let data = UserData(id: nil, username: username, password: password,
                            repeatPassword: nil, email: nil, name: nil, surname: nil, bio: nil, creditCard: nil, gender: nil)
        auth.login(with: data) { response in
            switch response.result {
            case .success(let result):
                let title = R.string.localizable.successfulMessage()
                self.showAlert(title: "\(title) ID: \(result.user.id)") { _ in
                    User.authUser = result.user
                    Analytics.logEvent("Login", parameters: [
                        "Success": true,
                        "User ID": result.user.id,
                        "Username": result.user.username
                    ])
                    self.router.toProfile()
                }
            case .failure(let error):
                Analytics.logEvent("Login", parameters: [
                    "Success": false
                ])
                Crashlytics.sharedInstance().recordError(error)
                self.showAlert(title: error.localizedDescription)
            }
        }
    }
    
}
