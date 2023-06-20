// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EasyKeyboard",
    platforms: [
        .iOS("13.0"), 
        .macOS("11.0")
    ],
    products: [
        .library(name: "EasyKeyboard", targets: ["EasyKeyboard"]),
    ],
    targets: [
        .target(name: "EasyKeyboard", dependencies: []),
        .testTarget(name: "EasyKeyboardTests", dependencies: ["EasyKeyboard"]),
    ]
)
