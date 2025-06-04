// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "OpenAsyncImage",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1)],
    products: [
        .library(name: "OpenAsyncImageKit", targets: ["OpenAsyncImageKit"]),
        .library(name: "OpenAsyncImagePlayground", targets: ["OpenAsyncImagePlayground"]),
    ],
    dependencies: [
        .package(url: "https://github.com/OpenSwiftUIProject/SymbolLocator.git", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "COpenAsyncImage",
            dependencies: [.product(
                name: "SymbolLocator",
                package: "SymbolLocator"
            )],
            publicHeadersPath: "."
        ),
        .target(
            name: "OpenAsyncImage",
            dependencies: ["COpenAsyncImage"],
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
        .target(
            name: "OpenAsyncImageKit",
            dependencies: ["OpenAsyncImage"],
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
        .target(
            name: "OpenAsyncImagePlayground",
            dependencies: ["OpenAsyncImageKit"],
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
    ]
)
