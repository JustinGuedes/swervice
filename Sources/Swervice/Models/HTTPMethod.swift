import Foundation

public enum HTTPMethod: String {
    case delete, get, patch, post, put
}

extension HTTPMethod {
    
    var value: String {
        return rawValue.uppercased()
    }
    
}
