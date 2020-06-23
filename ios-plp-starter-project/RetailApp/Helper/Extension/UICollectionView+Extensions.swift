//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

extension UICollectionView {

    func dequeueCell<Cell: UICollectionViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> Cell {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    }

}
