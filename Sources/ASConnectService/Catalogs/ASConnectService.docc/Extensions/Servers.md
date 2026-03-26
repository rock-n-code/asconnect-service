# ``Servers``

Server URLs defined in the OpenAPI document.

## Overview

The ``Servers`` namespace provides access to the base URLs defined in the App Store Connect API OpenAPI specification. Use these URLs when creating a ``Client`` instance.

```swift
let client = Client(
    serverURL: try Servers.Server1.url(),
    transport: URLSessionTransport(),
    middlewares: [
        BearerAuthMiddleware(token: yourJWTToken)
    ]
)
```

## Topics

### Server URLs

- ``Servers/Server1``
- ``Servers/server1()``
