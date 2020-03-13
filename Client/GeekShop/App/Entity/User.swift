//
//  User.swift
//  GeekShop
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation
import Crashlytics
import FirebaseAnalytics

struct User: Codable {
    // swiftlint:disable identifier_name
    let id: Int
    let username: String
    let email: String?
    let name: String?
    let surname: String?
    let bio: String?
    let creditCard: String?
    let gender: String?
    let creationDate: Date
    
    static var authUser: User? {
        willSet {
            guard let user = newValue else {
                Crashlytics.sharedInstance().setUserIdentifier(nil)
                Crashlytics.sharedInstance().setUserName(nil)
                Analytics.setUserID(nil)
                Analytics.setUserProperty(nil, forName: "Username")
                return
            }
            Crashlytics.sharedInstance().setUserIdentifier(String(user.id))
            Crashlytics.sharedInstance().setUserName(user.username)
            Analytics.setUserID(String(user.id))
            Analytics.setUserProperty(user.username, forName: "Username")
        }
    }
}

struct UserData {
    // swiftlint:disable identifier_name
    let id: Int?
    let username: String
    let password: String
    let repeatPassword: String?
    let email: String?
    let name: String?
    let surname: String?
    let bio: String?
    let creditCard: String?
    let gender: String?
}
