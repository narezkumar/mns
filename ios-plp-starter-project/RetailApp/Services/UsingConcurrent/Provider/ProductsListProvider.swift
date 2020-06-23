//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import Foundation

final class ProductsListProvider {
  private let operationQueue = OperationQueue()
  
  @discardableResult
  init(servicesProvider: ServicesProvider, completion: @escaping (Products?, UserOffers?) -> Void) {
        
    // Create the separate operations
    let userOfferDataRequestOperation = UserOfferDataRequestOperation(servicesProvider: servicesProvider)
    let productListOutputOperation = ProductListOutputOperation(servicesProvider: servicesProvider, completion: completion)
    
    let operations = [userOfferDataRequestOperation, productListOutputOperation]
    
    // Add operation dependencies
    productListOutputOperation.addDependency(userOfferDataRequestOperation)
    
    operationQueue.addOperations(operations, waitUntilFinished: false)
  }
  
  func cancel() {
    operationQueue.cancelAllOperations()
  }
}
