//
//  GetReviewsResponse.swift
//  GeekShop
//
//  Created by Artem Kufaev on 19.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

struct GetReviewsResponse: Codable {
    let result: Int
    let reviews: [ProductReview]
}
