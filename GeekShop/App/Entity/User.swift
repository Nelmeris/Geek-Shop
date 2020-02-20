//
//  User.swift
//  GeekShop
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation
import Crashlytics

struct User: Codable {
    let id: Int
    let username: String
    let email: String?
    let creationDate: Date
    let name: String?
    let surname: String?
    let bio: String?
    let creditCard: String?
    let gender: String?
    
    static var authUser: User? {
        willSet {
            guard let user = newValue else { return }
            Crashlytics.sharedInstance().setUserIdentifier(String(user.id))
        }
    }
}
