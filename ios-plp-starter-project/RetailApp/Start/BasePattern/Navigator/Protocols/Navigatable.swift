//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

protocol Navigatable: Presentable {
    // MARK: Properties

    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }

    
    // MARK: Public functions

    func present(_ module: Presentable, animated: Bool)
    func dismiss(animated: Bool)
    func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
    func setRoot(_ module: Presentable, hideBar: Bool)
    func popToRoot(animated: Bool)
}
