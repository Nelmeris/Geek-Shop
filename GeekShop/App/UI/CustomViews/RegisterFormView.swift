//
//  RegisterFormView.swift
//  GeekShop
//
//  Created by Artem Kufaev on 15.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class RegisterFormView: UIView {
    
    private(set) lazy var usernameField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Username"
        view.borderStyle = .roundedRect
        view.textContentType = .username
        return view
    }()
    
    private(set) lazy var nameField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Имя"
        view.borderStyle = .roundedRect
        view.textContentType = .givenName
        return view
    }()
    
    private(set) lazy var surnameField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Фамилия"
        view.borderStyle = .roundedRect
        view.textContentType = .familyName
        return view
    }()
    
    private(set) lazy var passwordField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Password"
        view.borderStyle = .roundedRect
        view.textContentType = .newPassword
        view.isSecureTextEntry = true
        return view
    }()
    
    private(set) lazy var repeatPasswordField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Repeat password"
        view.borderStyle = .roundedRect
        view.textContentType = .newPassword
        view.isSecureTextEntry = true
        return view
    }()
    
    private(set) lazy var emailField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "example@mail.ru"
        view.borderStyle = .roundedRect
        view.textContentType = .emailAddress
        view.keyboardType = .emailAddress
        return view
    }()
    
    private(set) lazy var genderField: GenderPicker = {
        let view = GenderPicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Male"
        view.borderStyle = .roundedRect
        return view
    }()
    
    private(set) lazy var creditCardField: CreditCardField = {
        let view = CreditCardField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "1234 1234 1234 1234"
        view.borderStyle = .roundedRect
        return view
    }()
    
    private(set) lazy var bioTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.isSelectable = true
        view.isEditable = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.addSubview(scrollView)
        self.scrollView.addSubview(scrollContainerView)
        self.scrollContainerView.addSubview(usernameField)
        self.scrollContainerView.addSubview(nameField)
        self.scrollContainerView.addSubview(surnameField)
        self.scrollContainerView.addSubview(passwordField)
        self.scrollContainerView.addSubview(repeatPasswordField)
        self.scrollContainerView.addSubview(emailField)
        self.scrollContainerView.addSubview(genderField)
        self.scrollContainerView.addSubview(creditCardField)
        self.scrollContainerView.addSubview(bioTextView)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.scrollContainerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.scrollContainerView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
            self.scrollContainerView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor),
            self.scrollContainerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.scrollContainerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.usernameField.topAnchor.constraint(equalTo: self.scrollContainerView.topAnchor, constant: 20),
            self.usernameField.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.usernameField.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            
            self.nameField.topAnchor.constraint(equalTo: self.usernameField.bottomAnchor, constant: 20),
            self.nameField.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.nameField.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            
            self.surnameField.topAnchor.constraint(equalTo: self.nameField.bottomAnchor, constant: 20),
            self.surnameField.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.surnameField.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            
            self.passwordField.topAnchor.constraint(equalTo: self.surnameField.bottomAnchor, constant: 20),
            self.passwordField.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.passwordField.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            
            self.repeatPasswordField.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 20),
            self.repeatPasswordField.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.repeatPasswordField.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            
            self.emailField.topAnchor.constraint(equalTo: self.repeatPasswordField.bottomAnchor, constant: 20),
            self.emailField.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.emailField.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            
            self.genderField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 20),
            self.genderField.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.genderField.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            
            self.creditCardField.topAnchor.constraint(equalTo: self.genderField.bottomAnchor, constant: 20),
            self.creditCardField.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.creditCardField.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            
            self.bioTextView.topAnchor.constraint(equalTo: self.creditCardField.bottomAnchor, constant: 20),
            self.bioTextView.leftAnchor.constraint(equalTo: self.scrollContainerView.leftAnchor, constant: 20),
            self.bioTextView.rightAnchor.constraint(equalTo: self.scrollContainerView.rightAnchor, constant: -20),
            self.bioTextView.bottomAnchor.constraint(equalTo: self.scrollContainerView.bottomAnchor, constant: -20)
        ])
    }
    
}
