import Foundation

public struct URLRequestBuilder {
    
    var scheme: String = "https"
    var host: String?
    var path: String?
    var queries: [URLQueryItem] = []
    var headers: [String: String] = [:]
    var method: HTTPMethod?
    var body: Data?
    
    public init() {}
    
    public func set(scheme: String) -> URLRequestBuilder {
        var builder = self
        builder.scheme = scheme
        return builder
    }
    
    public func set(host: String) -> URLRequestBuilder {
        var builder = self
        builder.host = host
        return builder
    }
    
    public func set(path: String) -> URLRequestBuilder {
        var builder = self
        builder.path = path
        return builder
    }
    
    public func set(queries: [URLQueryItem]) -> URLRequestBuilder {
        var builder = self
        builder.queries = queries
        return builder
    }
    
    public func add(query: URLQueryItem) -> URLRequestBuilder {
        var builder = self
        builder.queries.append(query)
        return builder
    }
    
    public func add(query name: String, value: String) -> URLRequestBuilder {
        let query = URLQueryItem(name: name, value: value)
        return add(query: query)
    }
    
    public func set(headers: [String: String]) -> URLRequestBuilder {
        var builder = self
        builder.headers = headers
        return builder
    }
    
    public func add(header name: String, value: String) -> URLRequestBuilder {
        var builder = self
        builder.headers[name] = value
        return builder
    }
    
    public func set(method: HTTPMethod) -> URLRequestBuilder {
        var builder = self
        builder.method = method
        return builder
    }
    
    public func set(body: Data) -> URLRequestBuilder {
        var builder = self
        builder.body = body
        return builder
    }
    
    public func set<T: Encodable>(body: T, encoder: JSONEncoder = .normal) throws -> URLRequestBuilder {
        let data = try encoder.encode(body)
        return set(body: data)
            .add(contentType: "application/json")
    }
    
    public func set(body: [String: String]) throws -> URLRequestBuilder {
        let form = body.reduce([String]()) { (result, entry) in
            result + ["\(entry.key)=\(entry.value)"]
        }.joined(separator: "&")
        
        guard let formData = form.data(using: .utf8) else {
            throw URLRequestError.invalidFormData
        }
        
        return set(body: formData)
            .add(contentType: "application/x-www-form-urlencoded")
    }
    
    public func build() throws -> URLRequest {
        let url = try buildURL()
        guard let method = method else {
            throw URLRequestError.invalidMethod
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.value
        request.httpBody = body
        return request
    }
    
    func buildURL() throws -> URL {
        guard let host = host else {
            throw URLRequestError.invalidHost
        }
        
        guard let path = path else {
            throw URLRequestError.invalidPath
        }

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queries.isEmpty ? nil : queries
        guard let url = components.url else {
            throw URLRequestError.invalidURL
        }
        
        return url
    }
    
}

public extension URLRequestBuilder {
    
    func add(contentType: String) -> URLRequestBuilder {
        return add(header: "Content-Type", value: contentType)
    }
    
    func add(authorization: Authorization) throws -> URLRequestBuilder {
        return add(header: "Authorization", value: try authorization.encoded())
    }
    
}
