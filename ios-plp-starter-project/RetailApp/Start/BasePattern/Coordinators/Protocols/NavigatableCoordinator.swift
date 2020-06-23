//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

protocol NavigatableCoordinator: Coordinator, Presentable {
    // MARK: Properties

    var navigator: Navigatable { get }
}
