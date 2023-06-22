import Foundation

public protocol ServiceErrorInterceptor {
    func intercept(_ error: Error) async -> Error
}

struct DefaultServiceErrorInterceptor: ServiceErrorInterceptor {
    
    func intercept(_ error: Error) async -> Error {
        return error
    }
    
}
