// ===----------------------------------------------------------------------===
//
// This source file is part of the ASConnectService open source project
//
// Copyright (c) 2026 Röck+Cöde VoF. and the ASConnectService project authors
// Licensed under Apache license v2.0
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of ASConnectService project authors
//
// SPDX-License-Identifier: Apache-2.0
//
// ===----------------------------------------------------------------------===

import struct Foundation.URL
import struct Foundation.URLComponents
import struct Foundation.URLQueryItem
import struct HTTPTypes.HTTPField
import struct HTTPTypes.HTTPFields
import struct HTTPTypes.HTTPRequest
import struct HTTPTypes.HTTPResponse
import protocol OpenAPIRuntime.ClientMiddleware
import class OpenAPIRuntime.HTTPBody

/// A client middleware that injects a Bearer authentication token into outgoing HTTP requests.
///
/// This middleware appends an `Authorization` header with a Bearer token to every request
/// before forwarding it to the next handler in the middleware chain. It is intended for use
/// with the App Store Connect API, which requires JSON Web Token (JWT) authentication.
///
/// ## Usage
///
/// ```swift
/// let middleware = BearerAuthMiddleware(token: "your-jwt-token")
/// ```
public struct BearerAuthMiddleware {
    // MARK: Properties

    /// The Bearer token to include in the `Authorization` header of each request.
    private let token: String

    // MARK: Initializers

    /// Creates a new middleware instance with the given Bearer token.
    /// - Parameter token: A JSON Web Token (JWT) string used to authenticate requests to the App Store Connect API.
    init(token: String) {
        self.token = token
    }
}

// MARK: - ClientMiddleware

extension BearerAuthMiddleware: ClientMiddleware {
    // MARK: Methods

    /// Intercepts an outgoing HTTP request and adds a Bearer authentication token to its headers.
    /// - Parameters:
    ///   - request: The original HTTP request.
    ///   - body: The optional body of the request.
    ///   - baseURL: The base URL for the request.
    ///   - operationID: The identifier of the API operation being performed.
    ///   - next: The next handler in the middleware chain.
    /// - Returns: The HTTP response and optional body returned by the next handler.
    public func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.authorization] = "Bearer \(token)"

        return try await next(
            request,
            body,
            baseURL
        )
    }
}
