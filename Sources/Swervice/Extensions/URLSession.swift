import Foundation

extension URLSession: ServiceClient {
    
    public func send<T: Decodable>(request: URLRequest, decoder: JSONDecoder) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            dataTask(with: request) { data, response, error in
                guard let data = data else {
                    continuation.resume(throwing: error ?? URLSessionError.unknown)
                    return
                }
                
                do {
                    let result = try decoder.decode(T.self, from: data)
                    continuation.resume(returning: result)
                } catch {
                    continuation.resume(throwing: error)
                }
                
            }
            .resume()
        }
    }
    
}
