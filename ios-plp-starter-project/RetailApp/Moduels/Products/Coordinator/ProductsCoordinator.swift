//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

final class ProductsCoordinator: BaseCoordinator<DeepLink> {
    
    // MARK: Properties

    private let dependencyProvider: ProductsCoordinatorDependencyProvider & ProductDetailsCoordinatorDependencyProvider
    
    // MARK: Initializers

    init(navigator: Navigatable, dependencyProvider: ProductsCoordinatorDependencyProvider & ProductDetailsCoordinatorDependencyProvider) {
        self.dependencyProvider = dependencyProvider
        super.init(navigator: navigator)
    }
    
    // MARK: Internal functions
    
    override func start() {
    }
    
    override func start(with link: DeepLink?) {
        guard let link = link else {
            return
        }
        switch link {
        case .products:
            print("home")
            
        case .productsdetails:
            print("details")
        }
    }
    
    override func toPresentable() -> UIViewController {
        return showProducts(for: self)
    }
}

// MARK: Extension

extension ProductsCoordinator: ProductsNavigator{
    func showProducts(for navigator: ProductDetailsNavigator) -> ProductsViewController{
        let productsViewController = self.dependencyProvider.productsViewController(navigator: navigator)
        return productsViewController
    }
}

extension ProductsCoordinator: ProductDetailsNavigator{
    func showProductDetails(for productRequest: ProductRequest, listingImage: UIImage?){
        let productDetailsViewController = self.dependencyProvider.productDetailsViewController(productRequest: productRequest, listingImage: listingImage)
        self.navigator.push(productDetailsViewController, animated: true, completion: nil)
    }
}
