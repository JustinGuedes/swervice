import Foundation

public protocol ServiceClient {
    func send<T: Decodable>(request: URLRequest, decoder: JSONDecoder) async throws -> T
}
