// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProximitySensor",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ProximitySensor",
            targets: ["ProximitySensor"]),
    ],
    targets: [
        .target(
            name: "ProximitySensor",
            dependencies: []),
    ]
)
