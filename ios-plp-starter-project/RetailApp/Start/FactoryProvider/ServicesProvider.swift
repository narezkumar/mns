//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import Foundation

// MARK: Service

///To declare all the SDK app utilize eg. Firebase, other libraries
protocol ServiceProviderType {}

struct ServicesProvider {
    
    // MARK: Properties

    let imageService: ImageService
    let userService: UserService
    let productsService: ProductsService
    let productDetailsService: ProductDetailsService

    
    // MARK: Static methods

    static func defaultProvider() -> ServicesProvider {
        ServicesProvider(imageService: ImageServiceImplementation(api:api()), userService: UserServiceImplementation(api: api()), productsService: ProductsServiceImplementation(api: api()), productDetailsService: ProductDetailsServiceImplementation(api:api()))
    }
    
    static func api(_ url:URL = Environment.baseURL) -> API{
        return API(baseURL: url)
    }
}
