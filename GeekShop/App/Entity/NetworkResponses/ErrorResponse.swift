//
//  ErrorResponse.swift
//  GeekShop
//
//  Created by Artem Kufaev on 14.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable, Error, LocalizedError {
    let result: Int
    let errorMessage: String
    
    var errorDescription: String? {
        return errorMessage
    }
    
}
