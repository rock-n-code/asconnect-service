# App Store Connect Service (ASConnectService)

A Swift client library for the App Store Connect API, generated from the official OpenAPI specification.

## Overview

`ASConnectService` provides a type-safe, Swift-native interface to Apple's App Store Connect API. This package enables developers to programmatically interact with App Store Connect services for managing apps, builds, reviews, sales reports, and more.

The library is automatically generated from the official App Store Connect API OpenAPI specification using Apple's [swift-openapi-generator](https://github.com/apple/swift-openapi-generator), ensuring complete API coverage and type safety.

## Installation

Add `ASConnectService` as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/rock-n-code/asconnect-service.git", from: "1.0.0")
]
```

Then add it to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        "ASConnectService"
    ]
)
```

## Usage

### Creating a Client

Create a `Client` instance by providing a server URL and transport. Use `BearerAuthMiddleware` to authenticate requests with a JSON Web Token (JWT).

The App Store Connect API requires authentication using API keys. You'll need to:

1. Create an API key in App Store Connect
2. Generate a signed JWT token using your key ID, issuer ID, and private key
3. Pass the token to the built-in `BearerAuthMiddleware` when creating the client

```swift
import ASConnectService
import OpenAPIURLSession

let client = Client(
    serverURL: try Servers.server1(),
    transport: URLSessionTransport(),
    middlewares: [
        BearerAuthMiddleware(token: yourJWTToken)
    ]
)
```

### Making API Calls

The `Client` conforms to `APIProtocol`, which defines a method for every endpoint in the App Store Connect API. Each method accepts an `Input` value and returns an `Output` value with the response.

```swift
let response = try await client.appsGetCollection(.init())
```

## Supported Platforms

- iOS 13.0+
- macOS 10.15+
- tvOS 13.0+
- visionOS 1.0+
- watchOS 6.0+

## Development

### Building

```bash
make lib-build
```

### Testing

```bash
make lib-test
```

### Generating Documentation

```bash
# Generate documentation archive (for Xcode)
make doc-generate-archive

# Generate documentation for static hosting (e.g. GitHub Pages)
make doc-generate-github

# Preview documentation locally in Safari
make doc-preview
```

## Dependencies

- [swift-openapi-generator](https://github.com/apple/swift-openapi-generator)
- [swift-openapi-runtime](https://github.com/apple/swift-openapi-runtime)
- [swift-openapi-urlsession](https://github.com/apple/swift-openapi-urlsession)
- [swift-docc-plugin](https://github.com/swiftlang/swift-docc-plugin)

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for details.

## Contributing

See [CONTRIBUTORS](CONTRIBUTORS) for the list of project authors.
