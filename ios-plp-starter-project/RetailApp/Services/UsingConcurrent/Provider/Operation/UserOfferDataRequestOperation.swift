//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

final class UserOfferDataRequestOperation: ConcurrentOperation {
    fileprivate let servicesProvider: ServicesProvider
    fileprivate let completion: ((Products?, UserOffers?) -> Void)?
    fileprivate var loadedData: UserOffers?

    init(servicesProvider: ServicesProvider, completion: ((Products?, UserOffers?) -> Void)? = nil) {
        self.servicesProvider = servicesProvider
        self.completion = completion
        super.init()
    }
    
    override func main() {
      if isCancelled { return }
        
        servicesProvider.userService.getUserOffers(id: "2") { [weak self] result in
            guard let self = self else { return }
            if self.isCancelled { return }
            do {
                self.loadedData = try result.unwrapped()
                self.completion?(nil, self.loadedData)
            } catch {
                self.loadedData = nil
                self.completion?(nil, nil)
                print(error.localizedDescription)
            }
            self.state = .finished
        }
    }
}

extension UserOfferDataRequestOperation: UserOfferOutputOperationDataProvider {
  var decodedData: UserOffers? { loadedData }
}
