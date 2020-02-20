//
//  ProductReviewTableViewCell.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class ProductReviewTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        self.setupLayout()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    public func configure(with viewModel: ProductReviewViewModel) {
        self.authorNameLabel.text = viewModel.autherName
        self.contentLabel.text = viewModel.content
    }
    
    // MARK: - Init setup
    
    private func configureUI() {
        self.selectionStyle = .none
    }
    
    private func setupLayout() {
        self.addSubview(authorNameLabel)
        self.addSubview(contentLabel)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.authorNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.authorNameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.authorNameLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.contentLabel.topAnchor.constraint(equalTo: self.authorNameLabel.bottomAnchor, constant: 20),
            self.contentLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.contentLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            self.contentLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])
    }
    
}
