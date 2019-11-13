// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtraBrainClient",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ExtraBrainClient",
            targets: ["ExtraBrainClient"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/alex-ross/swift-APIClient.git",
            from: "1.0.1"),
        .package(
            url: "https://github.com/alex-ross/swift-EasyMode.git",
            from: "1.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ExtraBrainClient",
            dependencies: ["APIClient", "EasyMode"]),
        .testTarget(
            name: "ExtraBrainClientTests",
            dependencies: ["ExtraBrainClient"]),
    ]
)
