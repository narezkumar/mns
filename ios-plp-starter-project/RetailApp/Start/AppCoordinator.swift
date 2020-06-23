//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

final class AppCoordinator: BaseCoordinator<DeepLink> {
    // MARK: Properties

    typealias DependencyProvider = ProductsCoordinatorDependencyProvider & ProductDetailsCoordinatorDependencyProvider

    private let dependencyProvider: DependencyProvider
    private lazy var productsCoordinator: ProductsCoordinator = {
        let coordinator = ProductsCoordinator(navigator: navigator, dependencyProvider: dependencyProvider)
        return coordinator
    }()
    
    
    // MARK: Initializers

    init(window: UIWindow?, navigator: Navigatable, dependencyProvider: DependencyProvider) {
        self.dependencyProvider = dependencyProvider
        super.init(navigator: navigator)
        window?.rootViewController = navigator.toPresentable()
        window?.makeKeyAndVisible()
    }
 
    // MARK: Public functions

    override func start() {
        productsCoordinator.start()
        navigator.setRoot(productsCoordinator, hideBar: false)
    }
}
