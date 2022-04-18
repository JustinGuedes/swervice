import Foundation

public protocol ServiceHelper {
    var config: ServiceHelperConfig { get }
    var client: ServiceClient { get }
}

public extension ServiceHelper {
    
    var client: ServiceClient {
        return URLSession.shared
    }
    
    func get<T: Decodable>(from path: String) async throws -> T {
        let request = try builder(for: .get, with: path)
            .build()
        
        return try await client.send(request: request, decoder: config.decoder)
    }
    
    func get<T: Decodable>(with parameters: [String: String], from path: String) async throws -> T {
        let queries = parameters.map(URLQueryItem.init)
        let request = try builder(for: .get, with: path)
            .set(queries: queries)
            .build()
        
        return try await client.send(request: request, decoder: config.decoder)
    }
    
    func post<T: Decodable>(_ form: [String: String], to path: String) async throws -> T {
        let request = try builder(for: .post, with: path)
            .set(body: form)
            .build()
        
        return try await client.send(request: request, decoder: config.decoder)
    }
    
    func post<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U {
        let request = try builder(for: .post, with: path)
            .set(body: request, encoder: config.encoder)
            .build()
        
        return try await client.send(request: request, decoder: config.decoder)
    }
    
    func put<T: Decodable>(_ form: [String: String], to path: String) async throws -> T {
        let request = try builder(for: .put, with: path)
            .set(body: form)
            .build()
        
        return try await client.send(request: request, decoder: config.decoder)
    }
    
    func put<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U {
        let request = try builder(for: .put, with: path)
            .set(body: request, encoder: config.encoder)
            .build()
        
        return try await client.send(request: request, decoder: config.decoder)
    }
    
    func builder(for method: HTTPMethod, with path: String) throws -> URLRequestBuilder {
        let builder = URLRequestBuilder()
            .set(host: config.host)
            .set(path: path)
            .set(method: method)
        
        if let authorization = config.authorization {
            return try builder
                .add(authorization: authorization)
        }
        
        return builder
    }
    
}
