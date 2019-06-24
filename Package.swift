// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "HotBoxKit",
    products: [
        .library(
            name: "HotBoxKit",
            targets: ["HotBoxKit"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HotBoxKit",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "HotBoxKitTests",
            dependencies: ["HotBoxKit"],
            path: "Tests"
        )
    ]
)
