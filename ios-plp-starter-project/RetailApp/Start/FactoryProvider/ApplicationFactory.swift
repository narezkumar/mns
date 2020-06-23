//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

/// The ApplicationFactory takes responsibity of creating application components and establishing dependencies between them.
final class ApplicationFactory:ServiceDepedency {
    // MARK: Properties

    var servicesProvider: ServicesProvider

    // MARK: Init

    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

// MARK: ProductsCoordinatorDependencyProvider

extension ApplicationFactory: ProductsCoordinatorDependencyProvider {
    
    func productsViewController(navigator: ProductDetailsNavigator) -> ProductsViewController{
        let controller = ProductsViewController()
        controller.setup(viewModel: ProductsViewModel(navigator: navigator, servicesProvider: self.servicesProvider))
        return controller
    }
}

// MARK: ProductDetailsCoordinatorDependencyProvider

extension ApplicationFactory: ProductDetailsCoordinatorDependencyProvider {
    
    func productDetailsViewController(productRequest: ProductRequest, listingImage: UIImage?) -> ProductDetailsViewController{
        let detailsViewController = ProductDetailsViewController()
        detailsViewController.setup(viewModel: ProductDetailsViewModel(productRequest: productRequest, listingImage: listingImage, servicesProvider: servicesProvider))
        return detailsViewController
    }
}
