//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import Foundation

// MARK: View Model

protocol ViewModel {}

protocol ViewModelConfigurable {
    func setup(viewModel: ViewModel)
}
