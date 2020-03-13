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
        let catalogTitle = R.string.localizable.catalogTitle()
        let catalogIcon = R.image.catalogueIcon()
        catalogVC.tabBarItem = UITabBarItem(title: catalogTitle, image: catalogIcon, tag: 0)
        let catalogNVC = UINavigationController(rootViewController: catalogVC)
        
        let basketVC = BasketModuleBuilder.build()
        let basketTitle = R.string.localizable.cartTitle()
        let cartIcon = R.image.cartIcon()
        basketVC.tabBarItem = UITabBarItem(title: basketTitle, image: cartIcon, tag: 1)
        let basketNVC = UINavigationController(rootViewController: basketVC)
        
        let profileVC = ProfileViewController()
        let profileTitle = R.string.localizable.profileTitle()
        let profileIcon = R.image.profileIcon()
        profileVC.tabBarItem = UITabBarItem(title: profileTitle, image: profileIcon, tag: 2)
        let profileNVC = UINavigationController(rootViewController: profileVC)
        
        return [catalogNVC, basketVC, profileNVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        self.viewControllers = controllers
    }
    
}
