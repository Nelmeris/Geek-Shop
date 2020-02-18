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
        let catalogVC = CatalogModelBuilder.build()
        catalogVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        let catalogNVC = UINavigationController(rootViewController: catalogVC)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let profileNVC = UINavigationController(rootViewController: profileVC)
        
        return [catalogNVC, profileNVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        self.viewControllers = controllers
    }
    
}
