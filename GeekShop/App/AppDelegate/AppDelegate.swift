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
        
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "crashlytics-send-reports", using: DispatchQueue.global()) { task in
//            self.sendReports(task: task)
//        }
        
        return true
    }
    
//    private func sendReports(task: BGTask) {
//        Crashlytics.crashlytics().checkForUnsentReports { isUnsentReports in
//            guard isUnsentReports else { return }
//            self.sendReports2(task: task)
//        }
//    }
    
//    private func sendReports2(task: BGTask? = nil) {
//        if UserDefaults.standard.bool(forKey: "isSendReports") {
//            Crashlytics.crashlytics().log("Test")
//            Crashlytics.crashlytics().sendUnsentReports()
//        } else {
//            Crashlytics.crashlytics().deleteUnsentReports()
//        }
//        task?.setTaskCompleted(success: true)
//    }

    func applicationWillResignActive(_ application: UIApplication) {
//        sendReports2()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
