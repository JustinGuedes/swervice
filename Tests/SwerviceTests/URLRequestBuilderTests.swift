import XCTest

import Swervice

final class URLRequestBuilderTests: XCTestCase {
    
    let testHost = "example.com"
    let testPath = "/test"
    
    func testBuildReturnsURLRequest() throws {
        let request = try URLRequestBuilder()
            .set(host: testHost)
            .set(path: testPath)
            .set(method: .get)
            .build()
        
        let expectedRequest = urlRequest(method: "GET")
        XCTAssertEqual(expectedRequest, request)
    }
    
    func testBuildReturnsURLRequestWithQueryParams() throws {
        let request = try URLRequestBuilder()
            .set(host: testHost)
            .set(path: testPath)
            .set(method: .get)
            .add(query: "title", value: "value")
            .build()
        
        let expectedRequest = urlRequest(method: "GET",
                                         query: ("title", "value"))
        XCTAssertEqual(expectedRequest, request)
    }
    
    func testBuildReturnsURLRequestWithHeader() throws {
        let request = try URLRequestBuilder()
            .set(host: testHost)
            .set(path: testPath)
            .set(method: .get)
            .add(header: "title", value: "value")
            .build()
        
        var expectedRequest = urlRequest(method: "GET")
        expectedRequest.allHTTPHeaderFields = ["title": "value"]
        XCTAssertEqual(expectedRequest, request)
    }
    
    func testBuildReturnsURLRequestWithJSONBody() throws {
        let body = TestData(value: "test")
        let request = try URLRequestBuilder()
            .set(host: testHost)
            .set(path: testPath)
            .set(method: .post)
            .set(body: body)
            .build()
        
        var expectedRequest = urlRequest(method: "POST")
        expectedRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        expectedRequest.httpBody = body.data
        XCTAssertEqual(expectedRequest, request)
    }
    
    func testBuildReturnsURLRequestWithFormBody() throws {
        let body = ["test": "value"]
        let request = try URLRequestBuilder()
            .set(host: testHost)
            .set(path: testPath)
            .set(method: .post)
            .set(body: body)
            .build()
        
        var expectedRequest = urlRequest(method: "POST")
        expectedRequest.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        expectedRequest.httpBody = "test=value".data(using: .utf8)
        XCTAssertEqual(expectedRequest, request)
    }
    
    func testBuildThrowsErrorWhenNoHostProvided() throws {
        let builder = URLRequestBuilder()
            .set(path: testPath)
            .set(method: .get)
        
        XCTAssertThrowsError(try builder.build())
    }
    
    func testBuildThrowsErrorWhenNoPathProvided() throws {
        let builder = URLRequestBuilder()
            .set(host: testHost)
            .set(method: .get)
        
        XCTAssertThrowsError(try builder.build())
    }
    
    func testBuildThrowsErrorWhenNoMethodProvided() throws {
        let builder = URLRequestBuilder()
            .set(host: testHost)
            .set(path: testPath)
        
        XCTAssertThrowsError(try builder.build())
    }
    
    func urlRequest(method: String, query: (String, String)? = nil) -> URLRequest {
        var components = URLComponents(string: "https://\(testHost)\(testPath)")!
        query.flatMap { components.queryItems = [URLQueryItem(name: $0.0, value: $0.1)] }
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        return request
    }
    
}

private struct TestData: Encodable {
    var value: String
    
    var data: Data {
        let encoder = JSONEncoder.normal
        return try! encoder.encode(self)
    }
}
