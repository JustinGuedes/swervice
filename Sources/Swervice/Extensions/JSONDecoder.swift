import Foundation

public extension JSONDecoder {
    
    static var normal: JSONDecoder {
        return JSONDecoder()
    }
    
    static var snakeCase: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
}
