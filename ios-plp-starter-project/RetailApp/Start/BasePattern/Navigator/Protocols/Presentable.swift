//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import Foundation
import UIKit

protocol Presentable {
    func toPresentable() -> UIViewController
}

extension UIViewController: Presentable {
    func toPresentable() -> UIViewController {
        self
    }
}
