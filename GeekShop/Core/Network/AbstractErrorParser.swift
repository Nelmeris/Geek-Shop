//
//  AbstractErrorParser.swift
<<<<<<< HEAD:Geek-Shop/Core/Network/AbstractErrorParser.swift
//  Geek-Shop
=======
//  GeekShop
>>>>>>> remotes/origin/feature/lesson-3:GeekShop/Core/Network/AbstractErrorParser.swift
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
