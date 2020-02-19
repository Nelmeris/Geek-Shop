//
//  ProductView.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class ProductView: UIView {
    
    private let reuseId = "reuse"
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var reviewTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductReviewTableViewCell.self, forCellReuseIdentifier: reuseId)
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func dequeueReusableCell(for indexPath: IndexPath) -> ProductReviewTableViewCell {
        return self.reviewTableView.dequeueReusableCell(withIdentifier: self.reuseId, for: indexPath) as! ProductReviewTableViewCell
    }
    
    public func configure(with product: Product) {
        self.titleLabel.text = product.title
        self.descriptionLabel.text = product.description
        self.priceLabel.text = NSDecimalNumber(decimal: product.price).stringValue
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        self.reviewTableView.bounces = false
    }
    
    private func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(priceLabel)
        self.addSubview(reviewTableView)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.priceLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.priceLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 20),
            self.descriptionLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.descriptionLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.reviewTableView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20),
            self.reviewTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.reviewTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            self.reviewTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    
}
