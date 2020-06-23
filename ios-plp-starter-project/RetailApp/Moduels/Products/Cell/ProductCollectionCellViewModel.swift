//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

class ProductCollectionCellViewModel: ViewModel {
    
    // MARK: - Properties
    var product = Observable<Product?>(nil)
    let name: Observable<String>
    let image: Observable<UIImage>
    let price: Observable<NSAttributedString>
    var badgeImage = Observable<UIImage?>(nil)

    let userOffers: UserOffers
    let imageService:ImageService
    
    // MARK: Initializers

    init(product: Product, userOffers: UserOffers, servicesProvider: ServicesProvider, priceFormatter: PriceFormatter = PriceFormatterImplementation()) {
        self.product.value = product
        self.userOffers = userOffers
        self.imageService = servicesProvider.imageService
        self.price = Observable<NSAttributedString>(priceFormatter.formatPrice(product.price))
        self.name = Observable<String>(product.name)
        self.image = Observable<UIImage>(#imageLiteral(resourceName: "Placeholder"))
        downloadBadge()
    }

}

extension ProductCollectionCellViewModel {
    
    private func downloadBadge() {
        guard let badgeName = getBadgeName() else {
         return
       }

       imageService.downloadImage(key: "\(badgeName)_icon") { [weak self] result in
         guard let self = self else { return }
         if let image = try? result.unwrapped() {
           self.badgeImage.value = image
         }
       }
     }
    
    private func getBadgeType() -> String?{
        guard let offerIds = product.value?.offerIds else { return nil }
        for item in userOffers.offers {
            if offerIds.contains(item.id) {
                return item.type
            }
        }
        return nil
    }
    
    private func getBadgeName() -> String? {
        let badges = userOffers.availableBadges.components(separatedBy: "||")

        guard let loyalty = badges.first, let sale = badges.last, let badgeType = getBadgeType() else {
            return nil
        }
        
        let loyaltybadges = loyalty.components(separatedBy: ":")
        let salebadges = sale.components(separatedBy: ":")
        
        guard let loyaltybadgeTypes = loyaltybadges.last, let salebadgeTypes = salebadges.last, let loyaltybadgeNames = loyaltybadges.first, let salebadgeNames = salebadges.first else {
            return nil
        }
        
        let loyaltyTypes = loyaltybadgeTypes.components(separatedBy: ",")
        let saleTypes = salebadgeTypes.components(separatedBy: ",")
        
        if loyaltyTypes.contains(badgeType) { return loyaltybadgeNames }
        if saleTypes.contains(badgeType) { return salebadgeNames }
        
        return nil
    }
}
