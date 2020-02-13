//
//  AuthorizationViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var router: AuthorizationRouter! {
        didSet { router.controller = self }
    }
    
    private var authView: AuthorizationView {
        return self.view as! AuthorizationView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = AuthorizationView(frame: self.view.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.router = AuthorizationRouter()
        self.authView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        self.authView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func login() {
        router.toLogin()
    }
    
    @objc private func register() {
        router.toRegister()
    }
    
}
