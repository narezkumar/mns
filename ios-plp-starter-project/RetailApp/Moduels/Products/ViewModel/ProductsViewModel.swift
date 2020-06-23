//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import UIKit

final class ProductsViewModel: ViewModel {

    // MARK: Properties
    private let productsService: ProductsService
    private let userService: UserService
    private let servicesProvider: ServicesProvider

    // MARK: - Properties
    var dataSource: CollectionViewDataSource<Product, ProductCollectionViewCell>?
    weak var navigator: ProductDetailsNavigator?

    // MARK: Initializers
    private var userOffers: UserOffers?
    private var productsList: Products?{
      didSet {
        guard let value = productsList else {
          return
        }
        productsDidLoad(value)
      }
    }
    
    // MARK: Initializers

    init(navigator: ProductDetailsNavigator, servicesProvider: ServicesProvider) {
        self.navigator = navigator
        self.servicesProvider = servicesProvider
        self.productsService = servicesProvider.productsService
        self.userService = servicesProvider.userService
    }

}

extension ProductsViewModel {
    
    func getProducts(_ completion: @escaping () -> Void) {
        productsService.getProducts { [weak self] result in
            guard let self = self else { return }
            do {
              self.productsList = try result.unwrapped()
              DispatchQueue.main.async { completion() }
            } catch {
              print(error.localizedDescription)
            }
        }
    }
    
    func getOffers(_ id:String, completion: @escaping () -> Void) {
        userService.getUserOffers(id: id) { [weak self] result in
            do {
                self?.userOffers = try result.unwrapped()
                DispatchQueue.global().async { completion() }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func product(for indexPath: IndexPath) -> Product? {
        return self.productsList?.products[indexPath.item]
    }
    
    
    private func productsDidLoad(_ productsList: Products) {
        if let userOffers = self.userOffers{
            self.dataSource = .make(for: productsList.products, userOffers: userOffers, servicesProvider: self.servicesProvider)
        }
    }
    
    ///tried another approach using operation queue and concurrency
    func getProductsUsingConcurrent(_ completion: @escaping () -> Void){
        ProductsListProvider(servicesProvider: servicesProvider) { [weak self] resultProducts, resultUserOffers in
            guard let self = self else { return }
            self.userOffers = resultUserOffers
            self.productsList = resultProducts
            DispatchQueue.main.async { completion() }
        }
    }
}
