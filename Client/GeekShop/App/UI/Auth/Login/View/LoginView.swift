//
//  LoginView.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = R.string.localizable.authorizationTitle()
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    private(set) lazy var usernameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = R.string.localizable.usernameField()
        field.borderStyle = .roundedRect
        field.textContentType = .username
        return field
    }()
    
    private(set) lazy var passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = R.string.localizable.passwordField()
        field.borderStyle = .roundedRect
        field.textContentType = .password
        field.isSecureTextEntry = true
        return field
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = R.string.localizable.loginButton()
        button.setTitle(title, for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        setupLayout()
        setupConstraints()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(usernameField)
        self.addSubview(passwordField)
        self.addSubview(loginButton)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.usernameField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.usernameField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.usernameField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.passwordField.topAnchor.constraint(equalTo: self.usernameField.bottomAnchor, constant: 20),
            self.passwordField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.passwordField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.loginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            self.loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
}
