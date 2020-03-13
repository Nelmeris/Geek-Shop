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
        return self.view as! ProfileEditorView
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
        let editingButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(logout))
        self.navigationItem.setRightBarButton(editingButton, animated: true)
        self.profileEditorView.changeButton.addTarget(self, action: #selector(changeData), for: .touchUpInside)
    }
    
    @objc private func changeData() {
        guard let username = self.profileEditorView.registerFormView.usernameField.text,
            let name = self.profileEditorView.registerFormView.nameField.text,
            let surname = self.profileEditorView.registerFormView.surnameField.text,
            let password = self.profileEditorView.registerFormView.passwordField.text,
            let repeatPassword = self.profileEditorView.registerFormView.repeatPasswordField.text,
            let email = self.profileEditorView.registerFormView.emailField.text,
            let gender = self.profileEditorView.registerFormView.genderField.text,
            let creditCard = self.profileEditorView.registerFormView.creditCardField.text,
            let bio = self.profileEditorView.registerFormView.bioTextView.text
            else { fatalError("Ошибка введения данных") }
        
        let model = RegisterInputModel(username: username, name: name, surname: surname, password: password, repeatPassword: repeatPassword, email: email, gender: gender, creditCard: creditCard, bio: bio)
        presenter.changeDataProcess(with: model)
    }
    
    @objc private func logout() {
        presenter.logoutProcess()
    }
    
}

extension ProfileEditorViewController: ProfileEditorController, AlertDelegate {
    
    func showResult(_ msg: String, completion: @escaping () -> ()) {
        showAlert(title: msg, message: nil) { _ in
            completion()
        }
    }
    
    func showError(_ error: Error) {
        showAlert(title: "Ошибка", message: error.localizedDescription)
    }
    
}
