import Foundation

struct BasicAuthDetails {
    // MARK: Constants
    let username: String
    let password: String
}


struct Resource<A> {
  let path: String
  let body: Data?
  let method: String
  let basicAuth: BasicAuthDetails
  let parse: (Data) -> Result<A, Error>
}

extension Resource where A: Decodable {
    init(path: String, basicAuth:BasicAuthDetails = BasicAuthDetails(username: Environment.username, password: Environment.password)) {
    self.path = path
    self.method = "GET"
    self.basicAuth = basicAuth
    self.body = nil
    parse = { data in
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return .value(try decoder.decode(A.self, from: data))
      } catch {
        print(error)
        return .error(error)
      }
    }
  }
}
