//
//  User.swift
<<<<<<< HEAD:Geek-Shop/App/Entity/User.swift
//  Geek-Shop
=======
//  GeekShop
>>>>>>> remotes/origin/feature/lesson-3:GeekShop/App/Entity/User.swift
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let name: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }
}
