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
    
    let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil) 
    }
    
    var profileView: ProfileView {
        return self.view as! ProfileView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = ProfileView()
        self.profileView.configure(with: user)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
