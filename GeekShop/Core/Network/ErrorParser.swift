//
//  ErrorParser.swift
<<<<<<< HEAD:Geek-Shop/Core/Network/ErrorParser.swift
//  Geek-Shop
=======
//  GeekShop
>>>>>>> remotes/origin/feature/lesson-3:GeekShop/Core/Network/ErrorParser.swift
//
//  Created by Artem Kufaev on 23/04/2019.
//  Copyright © 2019 Artem Kufaev. All rights reserved.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
