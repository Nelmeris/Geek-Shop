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
        label.text = R.string.localizable.registrationTitle()
        return label
    }()
    
    private(set) lazy var registerFormView: RegisterFormView = {
        let view = RegisterFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = R.string.localizable.signUpButton()
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
        self.addSubview(registerFormView)
        self.addSubview(registerButton)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.registerFormView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.registerFormView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.registerFormView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            self.registerButton.topAnchor.constraint(equalTo: self.registerFormView.bottomAnchor, constant: 20),
            self.registerButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.registerButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])
    }
    
}
