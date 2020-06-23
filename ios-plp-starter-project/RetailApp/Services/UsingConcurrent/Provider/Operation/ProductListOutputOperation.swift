//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

class ProductListOutputOperation: Operation {
  fileprivate let completion: (Products?, UserOffers?) -> Void
  fileprivate let servicesProvider: ServicesProvider
  fileprivate var productsList: Products?

  init(servicesProvider: ServicesProvider, completion: @escaping (Products?, UserOffers?) -> Void) {
    self.servicesProvider = servicesProvider
    self.completion = completion
    super.init()
  }
  
    override func main() {
      if isCancelled { return }

      let decodedData: UserOffers?
      
      let dataProvider = dependencies
          .filter { $0 is UserOfferOutputOperationDataProvider }
          .first as? UserOfferOutputOperationDataProvider
      decodedData = dataProvider?.decodedData
            
     servicesProvider.productsService.getProducts { result in
          do {
            self.productsList = try result.unwrapped()
            self.completion(self.productsList, decodedData)
          } catch {
            self.completion(nil, decodedData)
            print(error.localizedDescription)
          }
      }
    
    }
}
