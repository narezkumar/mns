//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

// MARK: Identifier

protocol Describable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension Describable {
    var typeName: String {
        String(describing: self)
    }

    static var typeName: String {
        String(describing: self)
    }
}

extension Describable where Self: NSObjectProtocol {
    var typeName: String {
        String(describing: type(of: self))
    }
}
