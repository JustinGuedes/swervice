import Foundation

public extension JSONEncoder {
    
    static var normal: JSONEncoder {
        return JSONEncoder()
    }
    
    static var snakeCase: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
}
