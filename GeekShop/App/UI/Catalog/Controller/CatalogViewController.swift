//
//  CatalogViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 18.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class CatalogViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var viewModels: [ProductViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.catalogView.tableView.reloadData()
            }
        }
    }
    
    private var catalogView: CatalogView {
        return self.view as! CatalogView
    }
    
    var presenter: CatalogPresenter!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = CatalogView()
        self.catalogView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadProducts()
        self.configureUI()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.title = "Каталог"
    }
    
}

// MARK: - Presenter
extension CatalogViewController: CatalogController, AlertDelegate {
    
    func showProducts(_ viewModels: [ProductViewModel]) {
        self.viewModels = viewModels
    }
    
    func showError(_ error: Error) {
        self.showAlert(title: error.localizedDescription)
    }
    
}

// MARK: - TableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.catalogView.dequeueReusableCell()
        let model = viewModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
}
