//
//  TabBarController.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    private lazy var controllers: [UIViewController] = {
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        return [UINavigationController(rootViewController: profileVC)]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        self.viewControllers = controllers
    }
    
}
