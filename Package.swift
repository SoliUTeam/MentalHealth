// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MentalHealth",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MentalHealth",
            targets: ["MentalHealth"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MentalHealth"),
        .testTarget(
            name: "MentalHealthTests",
            dependencies: ["MentalHealth"]),
    ]
)
