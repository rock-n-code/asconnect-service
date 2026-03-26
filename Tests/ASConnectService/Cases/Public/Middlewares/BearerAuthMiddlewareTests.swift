import Foundation
import HTTPTypes
import OpenAPIRuntime
import Testing

@testable import ASConnectService

@Suite("BearerAuthMiddleware")
struct BearerAuthMiddlewareTests {
    // MARK: Tests

    @Test("Adds the Authorization header with the Bearer token to the request")
    func addsAuthorizationHeader() async throws {
        let middleware = BearerAuthMiddleware(token: .Token.jwt)

        let (response, _) = try await middleware.intercept(
            .get,
            body: nil,
            baseURL: .base,
            operationID: "listApps",
            next: { interceptedRequest, body, baseURL in
                #expect(interceptedRequest.headerFields[.authorization] == "Bearer test-jwt-token")
                return (HTTPResponse(status: .ok), nil)
            }
        )

        #expect(response.status == .ok)
    }

    @Test("Forwards the request body to the next handler")
    func forwardsRequestBody() async throws {
        let middleware = BearerAuthMiddleware(token: .Token.jwt)
        let requestBody: HTTPBody = HTTPBody("request-body")

        var receivedBody: HTTPBody?

        _ = try await middleware.intercept(
            .get,
            body: requestBody,
            baseURL: .base,
            operationID: "createApp",
            next: { _, body, _ in
                receivedBody = body

                return (HTTPResponse(status: .created), nil)
            }
        )

        let bodyData = try await Data(collecting: try #require(receivedBody), upTo: .max)

        #expect(bodyData == Data("request-body".utf8))
    }

    @Test("Forwards the base URL to the next handler")
    func forwardsBaseURL() async throws {
        let middleware = BearerAuthMiddleware(token: .Token.jwt)
        let expectedBaseURL = URL.base

        _ = try await middleware.intercept(
            .get,
            body: nil,
            baseURL: expectedBaseURL,
            operationID: "listApps",
            next: { _, _, baseURL in
                #expect(baseURL == expectedBaseURL)

                return (HTTPResponse(status: .ok), nil)
            }
        )
    }

    @Test("Returns the response from the next handler")
    func returnsNextHandlerResponse() async throws {
        let middleware = BearerAuthMiddleware(token: .Token.jwt)
        let expectedBody: HTTPBody = HTTPBody("response-body")

        let (response, body) = try await middleware.intercept(
            .get,
            body: nil,
            baseURL: .base,
            operationID: "listApps",
            next: { _, _, _ in
                (HTTPResponse(status: .notFound), expectedBody)
            }
        )

        #expect(response.status == .notFound)

        let bodyData = try await Data(collecting: try #require(body), upTo: .max)

        #expect(bodyData == Data("response-body".utf8))
    }

    @Test("Preserves existing request headers")
    func preservesExistingHeaders() async throws {
        let middleware = BearerAuthMiddleware(token: .Token.jwt)

        var request = HTTPRequest.get

        request.headerFields[.contentType] = "application/json"

        _ = try await middleware.intercept(
            request,
            body: nil,
            baseURL: .base,
            operationID: "listApps",
            next: { interceptedRequest, _, _ in
                #expect(interceptedRequest.headerFields[.contentType] == "application/json")
                #expect(interceptedRequest.headerFields[.authorization] == "Bearer \(String.Token.jwt)")

                return (HTTPResponse(status: .ok), nil)
            }
        )
    }
}

// MARK: - HTTPRequest+Samples

private extension HTTPRequest {
    static let get = HTTPRequest(
        method: .get,
        scheme: "https",
        authority: "api.appstoreconnect.apple.com",
        path: "/v1/apps"
    )
}

// MARK: - String+Samples

private extension String {
    enum Token {
        static let jwt: String = "test-jwt-token"
    }
}

// MARK: - URL+Samples

private extension URL {
    static let base = URL(string: "https://api.appstoreconnect.apple.com")!
}
