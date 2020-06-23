import Foundation

struct Environment {

    static var baseURL: URL {
        let urlString = "http://interview-tech-testing.herokuapp.com"
        if let url = URL(string: urlString) {
            return url
        }
        fatalError("Failed to create url from \(urlString)")
    }

    static let username = "admin"
    static let password = "password"
}
