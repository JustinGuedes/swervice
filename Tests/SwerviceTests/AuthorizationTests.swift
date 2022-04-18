import XCTest

@testable import Swervice

final class AuthorizationTests: XCTestCase {
    
    func testEncodedBasicAuthorizationReturnsBase64String() throws {
        let input = Authorization.basic("username", "password")
        
        let result = try input.encoded()
        
        XCTAssertEqual("Basic dXNlcm5hbWU6cGFzc3dvcmQ=", result)
    }
    
    func testEncodedBearerAuthorizationReturnsString() throws {
        let input = Authorization.bearer("token")
        
        let result = try input.encoded()
        
        XCTAssertEqual("Bearer token", result)
    }
    
}
