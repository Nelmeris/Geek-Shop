//
//  ProductViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics

class ProductViewController: UIViewController {
    
    private var viewModels: [ProductReviewViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.productView.reviewTableView.reloadData()
            }
        }
    }
    public var presenter: ProductPresenter!
    
    private var productView: ProductView {
        guard let view = self.view as? ProductView else { fatalError() }
        return view
    }
    
    override func loadView() {
        super.loadView()
        self.view = ProductView()
        self.productView.reviewTableView.dataSource = self
        self.productView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadProduct()
        presenter.loadReviews()
    }
    
}

extension ProductViewController: ProductController {
    
    func showProduct(with product: Product) {
        self.title = product.title
        self.productView.configure(with: product)
    }
    
    func showReviews(with viewModels: [ProductReviewViewModel]) {
        self.viewModels = viewModels
    }
    
    func showError(_ error: Error) {
        let title = R.string.localizable.standartErrorTitle()
        self.showAlert(title: title, message: error.localizedDescription)
    }
    
    func showMessage(_ message: String) {
        self.showAlert(title: message)
    }
    
}

extension ProductViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productView.dequeueReusableCell(for: indexPath)
        let model = self.viewModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
}

extension ProductViewController: ProductViewDelegate {
    
    func addToBasketButtonDidClicked() {
        self.presenter.addToBasket()
    }
    
}
