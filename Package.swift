// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SproutSymbols",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(name: "SproutSymbols", targets: ["SproutSymbols"])
    ],
    targets: [
        .target(
            name: "SproutSymbols",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "SproutSymbolsTests",
            dependencies: ["SproutSymbols"]
        )
    ]
)
