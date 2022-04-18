# Swervice

A simple networking library for swift.

## Usage

The easiest way to fire off a service call is by using the `ServiceHelper`. For a more customised way of firing off service calls check the `URLRequestBuilder` section.

### ServiceHelper

Define your service class/struct and ensure it conforms to `ServiceHelper`:

```swift
struct ExampleService: ServiceHelper {
    
    // 1. Implement the config for the service you want to speak to
    var config: ServiceHelperConfig = .init(
        host: "example.com", // The host of the service
        authorization: .basic("username", "password) // The authorization for the service
    )
    
}
```

Once you have conformed to `ServiceHelper` you can implement your service specific methods:

```swift
struct ExampleService: ServiceHelper {
    
    // ...
    
    /// Fires off a GET request to https://example.com/api and returns
    /// a Response object provided no errors occur.
    func getTest() async throws -> Response {
        return try await get(from: "/api")
    }
    
}
```
### URLRequestBuilder

Description coming soon.

## License

Swervice is released under the MIT license. [See LICENSE](https://github.com/JustinGuedes/swervice/blob/main/LICENSE) for details.
