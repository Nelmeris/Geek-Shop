//
//  ProfileViewController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var router: ProfileRouter = {
        return ProfileRouter(controller: self)
    }()
    
    var profileView: ProfileView {
        return self.view as! ProfileView
    }
    
    override func loadView() {
        super.loadView()
        self.view = ProfileView()
        self.profileView.configure(with: User.authUser!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        self.title = "Профиль"
        let editingButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(startEditing))
        self.navigationItem.setRightBarButton(editingButton, animated: true)
    }
    
    @objc
    private func startEditing() {
        router.toEditor()
    }
    
}
