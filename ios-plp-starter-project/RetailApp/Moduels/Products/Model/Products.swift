//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import Foundation

// MARK: - MSProducts
struct Products: Codable {
    let products: [Product]
}

// MARK: - MSProduct
struct Product: Codable {
    let id, imageKey, name: String
    let offerIds: [String]
    let price: Price

    enum CodingKeys: String, CodingKey {
        case id
        case imageKey
        case name
        case offerIds
        case price
    }
}
