import Foundation

public struct ServiceHelperConfig {
    public var decoder: JSONDecoder
    public var encoder: JSONEncoder
    public var host: String
    public var authorization: Authorization?
    
    public init(decoder: JSONDecoder = .normal,
                encoder: JSONEncoder = .normal,
                host: String,
                authorization: Authorization? = nil) {
        self.decoder = decoder
        self.encoder = encoder
        self.host = host
        self.authorization = authorization
    }
}
