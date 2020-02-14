//
//  LoginResponse.swift
//  GeekShop
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let result: Int
    let user: User
}
