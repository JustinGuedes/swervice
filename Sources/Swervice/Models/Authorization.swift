import Foundation

public enum Authorization {
    case basic(String, String)
    case bearer(String)
}

extension Authorization {
    
    func encoded() throws -> String {
        switch self {
        case .basic(let username, let password):
            let token = "\(username):\(password)".data(using: .utf8)
            guard let token = token else {
                throw AuthorizationError.invalidBasicToken
            }

            return "Basic \(token.base64EncodedString())"
        case .bearer(let token):
            return "Bearer \(token)"
        }
    }
    
}
