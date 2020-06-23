//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

// MARK: ViewController

extension UIViewController {
    public static func identifier() -> String {
        String(describing: self)
    }
}
