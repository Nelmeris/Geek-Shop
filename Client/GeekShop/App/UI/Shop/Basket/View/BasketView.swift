//
//  BasketView.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

protocol BasketViewDelegate: class {
    func buyButtonDidClicked()
}

class BasketView: UIView {
    
    // MARK: - Properties
    
    private let reuseId = "reuse"
    public weak var delegate: BasketViewDelegate?
    
    // MARK: - Subviews
    
    private(set) lazy var productTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: reuseId)
        return tableView
    }()
    
    private(set) lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private(set) lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = R.string.localizable.makePurchaseButton()
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buyButtonDidClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc
    private func buyButtonDidClicked() {
        self.delegate?.buyButtonDidClicked()
    }
    
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
        self.addSubview(buyButton)
        self.addSubview(totalPriceLabel)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.productTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.productTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.productTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            self.totalPriceLabel.topAnchor.constraint(equalTo: self.productTableView.bottomAnchor, constant: 20),
            self.totalPriceLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.totalPriceLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 20),
            
            self.buyButton.topAnchor.constraint(equalTo: self.totalPriceLabel.bottomAnchor, constant: 20),
            self.buyButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.buyButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])
    }
    
}

// MARK: - Public methods
extension BasketView {
    
    public func setTotalPrice(with price: Decimal) {
        let title = R.string.localizable.totalPriceLabel()
        self.totalPriceLabel.text = "\(title): \(NSDecimalNumber(decimal: price).stringValue)"
    }
    
    public func dequeueReusableCell(for indexPath: IndexPath) -> BasketTableViewCell {
        guard let cell = self.productTableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
            as? BasketTableViewCell else { fatalError() }
        return cell
    }
    
}
