//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

protocol ServiceDepedency {
    var servicesProvider: ServicesProvider { get set }
}

protocol ProductsCoordinatorDependencyProvider: class {
    // Creates ProductsViewController
    func productsViewController(navigator: ProductDetailsNavigator) -> ProductsViewController
}

protocol ProductDetailsCoordinatorDependencyProvider: class {
    // Creates ProductDetailsViewController
    func productDetailsViewController(productRequest: ProductRequest, listingImage: UIImage?) -> ProductDetailsViewController
}

protocol ProductsNavigator: class {
    /// Presents the home screen
    func showProducts(for navigator: ProductDetailsNavigator) -> ProductsViewController
}

protocol ProductDetailsNavigator: class {
    /// Presents the details screen
    func showProductDetails(for productRequest: ProductRequest, listingImage: UIImage?)
}

