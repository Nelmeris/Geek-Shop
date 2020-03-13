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
    
    private let sendReportKey = "isSendReports"
    
    private lazy var router: AuthorizationRouter = { return AuthorizationRouter(controller: self) }()
    
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
        self.authView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        self.authView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        if UserDefaults.standard.object(forKey: sendReportKey) == nil {
            askPermissionSendReports()
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func login() {
        router.toLogin()
    }
    
    @objc
    private func register() {
        router.toRegister()
    }
    
}

extension AuthorizationViewController: AlertDelegate {
    
    private func askPermissionSendReports() {
        let title = "Отправка отчетов об ошибках"
        let message = "Вы разрешите нам отправлять анонимные отчеты об ошибках разработчикам?"
        self.showQuestion(title: title, message: message, actions: (
            { actionOk in
                UserDefaults.standard.set(true, forKey: self.sendReportKey)
            }, { actionCancel in
                UserDefaults.standard.set(false, forKey: self.sendReportKey)
            })
        )
    }
    
}
