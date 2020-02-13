//
//  AppStartManager.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

final class AppStartManager {
    
    var window: UIWindow?
    
    init(with window: UIWindow?) {
        if let window = window {
            self.window = window
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
    }
    
    func start() {
        let rootVC = AuthorizationViewController()
        let navVC = UINavigationController()
        navVC.viewControllers = [rootVC]
        
        window?.rootViewController = navVC
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
    
}
