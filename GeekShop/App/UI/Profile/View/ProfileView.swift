//
//  ProfileView.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Профиль"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.usernameLabel.text = "Username: \(user.username)"
        self.nameLabel.text = "Имя: \(user.name ?? "")"
        self.surnameLabel.text = "Фамилия: \(user.surname ?? "")"
    }
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(usernameLabel)
        self.addSubview(nameLabel)
        self.addSubview(surnameLabel)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
        
            self.usernameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.usernameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.usernameLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: 20),
            self.nameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.nameLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.surnameLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 20),
            self.surnameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.surnameLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            self.surnameLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -20)
        ])
    }
    
}
