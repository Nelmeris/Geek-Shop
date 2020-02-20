//
//  BasketViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 20.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class BasketViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: BasketPresenter!
    var viewModels: [BasketProductViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.basketView.productTableView.reloadData()
            }
        }
    }
    
    private var basketView: BasketView {
        return self.view as! BasketView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = BasketView()
        self.basketView.productTableView.dataSource = self
        self.basketView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadProducts()
    }
    
    private func configureUI() {
        self.title = "Корзина"
    }
    
}

// MARK: - Presenter implementation
extension BasketViewController: BasketController, AlertDelegate {
    
    func showMessage(_ message: String) {
        self.showAlert(title: message)
    }
    
    func showProducts(with products: [BasketProductViewModel]) {
        self.viewModels = products
    }
    
    func showError(_ error: Error) {
        self.showAlert(title: "Ошибка", message: error.localizedDescription)
    }
    
}

// MARK: - Table View Data Source
extension BasketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.basketView.dequeueReusableCell(for: indexPath)
        let viewModel = self.viewModels[indexPath.row]
        cell.configure(with: viewModel)
        cell.delegate = self
        return cell
    }
    
}

// MARK: - Table View Delegate
extension BasketViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.basketView.productTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Table View Cell Delegate
extension BasketViewController: BasketTableViewCellDelegate {
    
    func didRemove(for viewModel: BasketProductViewModel) {
        guard let index = self.viewModels.firstIndex(where: { $0 == viewModel }) else { return }
        self.presenter.productDidRemove(with: index)
    }
    
    func quantityDidChange(for viewModel: BasketProductViewModel, with quantity: Int) {
        guard let index = self.viewModels.firstIndex(where: { $0 == viewModel }) else { return }
        self.presenter.productDidChangeQuantity(for: index, with: quantity)
    }
    
}

extension BasketViewController: BasketViewDelegate {
    
    func buyButtonDidClicked() {
        self.presenter.makePurchase()
    }
    
}
