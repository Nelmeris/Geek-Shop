//
//  ProfileEditorView.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class ProfileEditorView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Редактирование"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var registerFormView: RegisterFormView = {
        let view = RegisterFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Изменить", for: .normal)
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
    
    func configure(with user: User) {
        self.registerFormView.usernameField.text = user.username
        self.registerFormView.nameField.text = user.name
        self.registerFormView.surnameField.text = user.surname
        self.registerFormView.emailField.text = user.email
        self.registerFormView.genderField.text = user.gender
        self.registerFormView.creditCardField.text = user.creditCard
        self.registerFormView.bioTextView.text = user.bio
    }
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(registerFormView)
        self.addSubview(changeButton)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            self.registerFormView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.registerFormView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.registerFormView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            self.changeButton.topAnchor.constraint(equalTo: self.registerFormView.bottomAnchor, constant: 20),
            self.changeButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.changeButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])
    }
    
}
