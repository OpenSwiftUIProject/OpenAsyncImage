// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "OpenAsyncImage",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1)],
    products: [
        .library(name: "OpenAsyncImage", targets: ["OpenAsyncImage"]),
        .library(name: "OpenAsyncImagePlayground", targets: ["OpenAsyncImagePlayground"]),
    ],
    targets: [
        .target(name: "OpenAsyncImage", swiftSettings: [.swiftLanguageMode(.v5)]),
        .target(name: "OpenAsyncImagePlayground", dependencies: ["OpenAsyncImage"], swiftSettings: [.swiftLanguageMode(.v5)]),
    ]
)
