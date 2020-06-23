import Foundation

protocol ProductsService {
  func getProducts(completion: @escaping (Result<Products, Error>) -> Void)
}

class ProductsServiceImplementation: ProductsService {
  private let api: API

  init(api: API) {
    self.api = api
  }

  func getProducts(completion: @escaping (Result<Products, Error>) -> Void) {
    let resource = Resource<Products>(path: "api/products")
    api.load(resource, completion: completion)
  }
}
