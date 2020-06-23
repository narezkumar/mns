//  Created by Naresh Kumar on 23/06/2020.
//  Copyright © 2020 Marks and Spencer. All rights reserved.

import Foundation

protocol UserService {
  func getUserOffers(id: String, completion: @escaping (Result<UserOffers, Error>) -> Void)
}

class UserServiceImplementation: UserService {
  private let api: API

  init(api: API) {
    self.api = api
  }

  func getUserOffers(id: String, completion: @escaping (Result<UserOffers, Error>) -> Void) {
    let resource = Resource<UserOffers>(path: "api/user/\(id)/offers")
    api.load(resource, completion: completion)
  }
}
