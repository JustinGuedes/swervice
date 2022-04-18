import Foundation

public enum URLRequestError: Error {
    case invalidHost
    case invalidPath
    case invalidMethod
    case invalidURL
    case invalidFormData
}
