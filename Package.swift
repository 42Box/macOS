// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Box42",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "Box42",
            targets: ["Box42"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.6.0"),
    ],
    targets: [
        .target(
            name: "Box42",
            dependencies: ["SnapKit"],
            resources: [.process("Box42/Resources/Assets.xcassets"),
                        .process("Box42/Resources/Main.storyboard"),
                        .process("Box42/Resources/sh/*.sh")]
        ),
    ]
)
