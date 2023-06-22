import Foundation

public enum URLSessionError: Error {
    case decoding(Data, Error)
    case unknown
}
