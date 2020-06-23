//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

import Foundation

// MARK: - UserOffers
struct UserOffers: Codable {
    let availableBadges: String
    let offers: [Offer]
    
    enum CodingKeys: String, CodingKey {
        case availableBadges
        case offers
    }
}

// MARK: - Offer
struct Offer: Codable {
    let id, title, type: String
}
