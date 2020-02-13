//
//  RegisterView.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.text = "Регистрация"
        return label
    }()
    
    private(set) lazy var usernameField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Username"
        view.borderStyle = .roundedRect
        view.textContentType = .username
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
        view.placeholder = "Something"
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
    
    private(set) lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Далее", for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.backgroundColor = .white
        setupLayout()
        setupConstraints()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(scrollView)
        self.scrollView.addSubview(scrollContainerView)
        self.scrollContainerView.addSubview(usernameField)
        self.scrollContainerView.addSubview(passwordField)
        self.scrollContainerView.addSubview(repeatPasswordField)
        self.scrollContainerView.addSubview(emailField)
        self.scrollContainerView.addSubview(genderField)
        self.scrollContainerView.addSubview(creditCardField)
        self.scrollContainerView.addSubview(bioTextView)
        self.scrollContainerView.addSubview(registerButton)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
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
            
            self.passwordField.topAnchor.constraint(equalTo: self.usernameField.bottomAnchor, constant: 20),
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
            
            self.registerButton.topAnchor.constraint(equalTo: self.bioTextView.bottomAnchor, constant: 20),
            self.registerButton.centerXAnchor.constraint(equalTo: self.scrollContainerView.centerXAnchor),
            
            self.registerButton.bottomAnchor.constraint(equalTo: self.scrollContainerView.bottomAnchor, constant: -20)
        ])
    }
    
}
