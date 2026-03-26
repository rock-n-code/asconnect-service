# ``ASConnectService``

A Swift client library for the App Store Connect API, generated from the official OpenAPI specification.

## Overview

``ASConnectService`` provides a type-safe, Swift-native interface to Apple's App Store Connect API. This package enables developers to programmatically interact with App Store Connect services for managing apps, builds, reviews, sales reports, and more.

The library is automatically generated from the official App Store Connect API OpenAPI specification using Apple's [swift-openapi-generator](https://github.com/apple/swift-openapi-generator), ensuring complete API coverage and type safety.

### Creating a Client

Create a ``Client`` instance by providing a server URL and transport. Use ``BearerAuthMiddleware`` to authenticate requests with a JSON Web Token (JWT).

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

The ``Client`` conforms to ``APIProtocol``, which defines a method for every endpoint in the App Store Connect API. Each method accepts an `Input` value and returns an `Output` value with the response.

```swift
let response = try await client.appsGetCollection(.init())
```

## Topics

### API Client

- ``Client``
- ``APIProtocol``

### Authentication

- ``BearerAuthMiddleware``

### Generated Types

- ``Components``
- ``Operations``
- ``Servers``
