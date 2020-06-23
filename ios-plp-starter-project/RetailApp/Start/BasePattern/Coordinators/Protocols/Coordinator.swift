//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

protocol Coordinator: class {
    // MARK: Properties

    associatedtype DeepLinkType
    var childCoordinators: [BaseCoordinator<DeepLinkType>] { get set }
    
    
    // MARK: Public functions

    func start()
    func start(with link: DeepLinkType?)
}
