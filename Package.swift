// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Swervice",
    platforms: [
        .iOS(.v14), .macOS(.v11)
    ],
    products: [
        .library(
            name: "Swervice",
            targets: ["Swervice"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Swervice",
            dependencies: []),
        .testTarget(
            name: "SwerviceTests",
            dependencies: ["Swervice"]),
    ]
)
