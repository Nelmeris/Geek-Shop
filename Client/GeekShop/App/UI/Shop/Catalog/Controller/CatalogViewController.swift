//
//  CatalogViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 18.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics
import FirebaseAnalytics

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
        self.catalogView.tableView.delegate = self
        setRefreshControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadProducts()
        Analytics.logEvent("OpenCatalog", parameters: nil)
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.title = R.string.localizable.catalogTitle()
    }
    
    private func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        self.catalogView.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadProducts), for: .valueChanged)
        
    }
    
    @objc
    private func reloadProducts() {
        presenter.loadProducts()
    }
    
}

// MARK: - Presenter
extension CatalogViewController: CatalogController, AlertDelegate {
    
    func showProducts(_ viewModels: [ProductViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.catalogView.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func showError(_ error: Error) {
        self.showAlert(title: error.localizedDescription)
    }
    
}

// MARK: - TableViewDataSource
extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.productDidSelect(for: indexPath)
    }
    
}
