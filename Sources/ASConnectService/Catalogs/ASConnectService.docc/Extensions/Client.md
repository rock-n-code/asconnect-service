# ``Client``

The API client for performing HTTP operations against the App Store Connect API.

## Overview

The ``Client`` struct is the main entry point for interacting with the App Store Connect API. It conforms to ``APIProtocol`` and provides concrete implementations for all available API operations.

### Creating a Client

Create a ``Client`` by providing a server URL, a transport, and optionally a list of middlewares for authentication or request customization.

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

Each method on the ``Client`` corresponds to an HTTP endpoint defined in the App Store Connect API OpenAPI specification. Methods accept an `Input` value and return an `Output` value representing the response.

```swift
let response = try await client.appsGetCollection(.init())
```

## Topics

### Creating a Client

- ``init(serverURL:configuration:transport:middlewares:)``
