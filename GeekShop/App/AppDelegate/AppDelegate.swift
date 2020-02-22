//
//  AppDelegate.swift
//  GeekShop
//
//  Created by Artem Kufaev on 17/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import UIKit
import Crashlytics
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appStartManager: AppStartManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appStartManager = AppStartManager(with: window)
        appStartManager?.start()
        
        return true
    }

}
