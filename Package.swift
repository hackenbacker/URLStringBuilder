// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "URLStringBuilder",
    products: [
        .library(
            name: "URLStringBuilder",
            targets: ["URLStringBuilder"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "URLStringBuilder",
            dependencies: []),
        .testTarget(
            name: "URLStringBuilderTests",
            dependencies: ["URLStringBuilder"]),
    ]
)
