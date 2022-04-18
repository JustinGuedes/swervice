import XCTest

@testable import Swervice

final class HTTPMethodTests: XCTestCase {
    
    func testValueReturnsUppercasedDelete() throws {
        let input = HTTPMethod.delete
        
        let result = input.value
        
        XCTAssertEqual("DELETE", result)
    }
    
    func testValueReturnsUppercasedGet() throws {
        let input = HTTPMethod.get
        
        let result = input.value
        
        XCTAssertEqual("GET", result)
    }
    
    func testValueReturnsUppercasedPatch() throws {
        let input = HTTPMethod.patch
        
        let result = input.value
        
        XCTAssertEqual("PATCH", result)
    }
    
    func testValueReturnsUppercasedPost() throws {
        let input = HTTPMethod.post
        
        let result = input.value
        
        XCTAssertEqual("POST", result)
    }
    
    func testValueReturnsUppercasedPut() throws {
        let input = HTTPMethod.put
        
        let result = input.value
        
        XCTAssertEqual("PUT", result)
    }
    
}
