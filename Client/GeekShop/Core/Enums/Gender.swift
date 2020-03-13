//
//  Gender.swift
//  GeekShop
//
//  Created by Artem Kufaev on 22.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

enum Gender {
    case male
    case female
    
    var string: String {
        switch self {
        case .male: return R.string.localizable.genderMale()
        case .female: return R.string.localizable.genderFemale()
        }
    }
}
