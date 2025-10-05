// swift-tools-version: 5.10

//===----------------------------------------------------------------------===
//
// This source file is part of the ASConnectService open source project
//
// Copyright (c) 2025 Röck+Cöde VoF. and the ASConnectService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of ASConnectService project authors
//
//===----------------------------------------------------------------------===

import PackageDescription

let package = Package(
    name: AppStoreConnectService.package,
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .visionOS(.v1),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: AppStoreConnectService.package,
            targets: [AppStoreConnectService.target]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0")
    ],
    targets: [
        .target(
            name: AppStoreConnectService.target,
            path: "Sources/ASConnectService"
        ),
        .testTarget(
            name: AppStoreConnectService.test,
            dependencies: [
                .byName(name: AppStoreConnectService.target)
            ],
            path: "Tests/ASConnectService"
        ),
    ]
)

// MARK: - Constants

enum AppStoreConnectService {
    static let package = "asconnect-service"
    static let target = "ASConnectService"
    static let test = "\(AppStoreConnectService.target)Tests"
}
