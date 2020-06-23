//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

class BaseNavigator: NSObject, Navigatable {
    // MARK: Constants
    
    let navigationController: UINavigationController
    
    
    // MARK: Properties
    
    var rootViewController: UIViewController? {
        navigationController.viewControllers.first
    }
    
    private var completions: [UIViewController : () -> Void]
    
    // MARK: Initialisers
    
    @objc init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
        self.navigationController.delegate = self
    }
    
    
    // MARK: Public functions
    
    func present(_ module: Presentable, animated: Bool) {
        navigationController.present(module.toPresentable(), animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }
    
    func push(_ module: Presentable, animated: Bool, completion: (() -> Void)? = nil) {
        let controller = module.toPresentable()
        guard controller is UINavigationController == false else {
            return
        }
        if let completion = completion {
            completions[controller] = completion
        }
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    public func setRoot(_ module: Presentable, hideBar: Bool = false) {
        completions.forEach { $0.value() }
        navigationController.setViewControllers([module.toPresentable()], animated: false)
        navigationController.isNavigationBarHidden = hideBar
    }
    
    public func popToRoot(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }
    
    // MARK: Private functions
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    // MARK: Presentable
    
    public func toPresentable() -> UIViewController {
        navigationController
    }
}


// MARK: NavigationControllerDelegate

extension BaseNavigator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController) else {
                return
        }
        runCompletion(for: poppedViewController)
    }
}
