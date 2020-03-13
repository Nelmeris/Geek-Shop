//
//  BasketTableViewCell.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

protocol BasketTableViewCellDelegate {
    func didRemove(for viewModel: BasketProductViewModel)
    func quantityDidChange(for viewModel: BasketProductViewModel, with quantity: Int)
}

class BasketTableViewCell: UITableViewCell {
    
    var viewModel: BasketProductViewModel?
    var delegate: BasketTableViewCellDelegate?
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var quantityField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.keyboardType = .numberPad
        field.borderStyle = .roundedRect
        field.setContentHuggingPriority(.init(249), for: .horizontal)
        return field
    }()
    
    var quantity: Int {
        get {
            guard let text = self.quantityField.text else { fatalError() }
            return Int(text)!
        }
        set {
            guard newValue >= 1 else { return }
            self.decreaseButton.isEnabled = newValue != 1
            self.quantityField.text = String(newValue)
            let price = Decimal(string: self.viewModel!.price)!
            self.priceLabel.text = NSDecimalNumber(decimal: price * Decimal(integerLiteral: newValue)).stringValue
            guard let model = viewModel else { return }
            self.delegate?.quantityDidChange(for: model, with: newValue)
        }
    }
    
    private(set) lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        return button
    }()
    
    private (set) lazy var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(removeButtonDidClick), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    private func increaseQuantity() {
        self.quantity += 1
    }
    
    @objc
    private func decreaseQuantity() {
        self.quantity -= 1
    }
    
    @objc
    private func removeButtonDidClick() {
        guard let model = viewModel else { return }
        self.delegate?.didRemove(for: model)
    }
    
    // MARK: - Configure view
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        self.addSubview(decreaseButton)
        self.addSubview(increaseButton)
        self.addSubview(quantityField)
        self.addSubview(removeButton)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            
            self.priceLabel.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.priceLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.rightAnchor, constant: 10),
            self.priceLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.decreaseButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20),
            self.decreaseButton.centerYAnchor.constraint(equalTo: self.quantityField.centerYAnchor),
            
            self.quantityField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
            self.quantityField.rightAnchor.constraint(equalTo: self.increaseButton.leftAnchor, constant: -10),
            self.quantityField.leftAnchor.constraint(equalTo: self.decreaseButton.rightAnchor, constant: 10),
            
            self.increaseButton.centerYAnchor.constraint(equalTo: self.quantityField.centerYAnchor),
            self.increaseButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20),
            
            self.removeButton.topAnchor.constraint(equalTo: self.quantityField.bottomAnchor, constant: 10),
            self.removeButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.removeButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        ])
    }
    
}

extension BasketTableViewCell {
    
    public func configure(with viewModel: BasketProductViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.priceLabel.text = viewModel.price
        self.quantity = Int(viewModel.quantity)!
    }
    
}
