//
//  ProfileEditorViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class ProfileEditorViewController: UIViewController {
    
    var profileEditorView: ProfileEditorView {
        guard let view = self.view as? ProfileEditorView else { fatalError() }
        return view
    }
    
    var presenter: ProfileEditorPresenter!
    
    override func loadView() {
        super.loadView()
        self.view = ProfileEditorView()
        self.profileEditorView.configure(with: User.authUser!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let logoutIcon = R.image.logoutIcon()
        let logoutButton = UIBarButtonItem(image: logoutIcon, style: .plain, target: self, action: #selector(logout))
        self.navigationItem.setRightBarButton(logoutButton, animated: true)
        self.profileEditorView.changeButton.addTarget(self, action: #selector(changeData), for: .touchUpInside)
    }
    
    @objc
    private func changeData() {
        guard let username = self.profileEditorView.registerFormView.usernameField.text,
            let name = self.profileEditorView.registerFormView.nameField.text,
            let surname = self.profileEditorView.registerFormView.surnameField.text,
            let password = self.profileEditorView.registerFormView.passwordField.text,
            let repeatPassword = self.profileEditorView.registerFormView.repeatPasswordField.text,
            let email = self.profileEditorView.registerFormView.emailField.text,
            let gender = self.profileEditorView.registerFormView.genderField.text,
            let creditCard = self.profileEditorView.registerFormView.creditCardField.text,
            let bio = self.profileEditorView.registerFormView.bioTextView.text
            else { fatalError("Fields text error") }
        
        let model = UserData(id: nil,
                             username: username,
                             password: name,
                             repeatPassword: surname,
                             email: password,
                             name: repeatPassword,
                             surname: email,
                             bio: gender,
                             creditCard: creditCard,
                             gender: bio)
        presenter.changeDataProcess(with: model)
    }
    
    @objc
    private func logout() {
        presenter.logoutProcess()
    }
    
}

extension ProfileEditorViewController: ProfileEditorController {
    
    func showResult(_ msg: String, completion: @escaping () -> Void) {
        showAlert(title: msg, message: nil) { _ in
            completion()
        }
    }
    
    func showError(_ error: Error) {
        let title = R.string.localizable.standartErrorTitle()
        showAlert(title: title, message: error.localizedDescription)
    }
    
}
