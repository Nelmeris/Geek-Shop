//
//  BasketView.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class BasketView: UIView {
    
    // MARK: - Properties
    
    private let reuseId = "reuse"
    
    // MARK: - Subviews
    
    private(set) lazy var productTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: reuseId)
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(productTableView)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.productTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.productTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.productTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            self.productTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
}

// MARK: - Public methods
extension BasketView {
    
    public func dequeueReusableCell(for indexPath: IndexPath) -> BasketTableViewCell {
        return self.productTableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! BasketTableViewCell
    }
    
}
