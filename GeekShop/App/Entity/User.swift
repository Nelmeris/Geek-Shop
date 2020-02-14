//
//  User.swift
//  GeekShop
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let creationDate: Date
    let name: String?
    let surname: String?
    let bio: String?
    let creditCard: String?
    let gender: String?
}
