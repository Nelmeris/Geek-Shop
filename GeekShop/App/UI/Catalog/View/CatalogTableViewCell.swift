//
//  CatalogTableViewCell.swift
//  GeekShop
//
//  Created by Artem Kufaev on 18.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var bottomConstraint: (price: NSLayoutConstraint, description: NSLayoutConstraint)!
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.priceLabel.text = nil
        self.setupDescription(nil)
    }
    
    public func configure(with model: ProductViewModel) {
        self.titleLabel.text = model.title
        self.priceLabel.text = model.price
        self.setupDescription(model.description)
    }
    
    private func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        self.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.bottomConstraint = (
            self.priceLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        )
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
            self.priceLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.rightAnchor, constant: 20),
            self.priceLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 20),
            self.descriptionLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.descriptionLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.bottomConstraint.price
        ])
    }
    
    private func setupDescription(_ description: String?) {
        if let description = description {
            self.descriptionLabel.text = description
            self.descriptionLabel.isHidden = false
            NSLayoutConstraint.deactivate([self.bottomConstraint.price])
            NSLayoutConstraint.activate([self.bottomConstraint.description])
        } else {
            self.descriptionLabel.text = nil
            self.descriptionLabel.isHidden = true
            NSLayoutConstraint.deactivate([self.bottomConstraint.description])
            NSLayoutConstraint.activate([self.bottomConstraint.price])
        }
    }
    
}
