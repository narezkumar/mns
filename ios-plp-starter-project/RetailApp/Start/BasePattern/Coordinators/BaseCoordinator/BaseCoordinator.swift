//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

class BaseCoordinator<DeepLinkType>: NSObject, NavigatableCoordinator {
    // MARK: Properties

    var childCoordinators: [BaseCoordinator<DeepLinkType>] = []
    var navigator: Navigatable
    
    
    // MARK: Initializers

    init(navigator: Navigatable) {
        self.navigator = navigator
    }
    
    
    // MARK: Public functions

    func addChild(_ coordinator: BaseCoordinator<DeepLinkType>) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: BaseCoordinator<DeepLinkType>?) {
        if let coordinator = coordinator, let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }
    
    func start() {
        start(with: nil)
    }
    
    func start(with link: DeepLinkType?) {}
    
    func toPresentable() -> UIViewController {
        navigator.toPresentable()
    }
}
