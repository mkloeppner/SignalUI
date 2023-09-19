// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SignalUI",
    platforms: [.iOS(.v14), .macOS(.v10_13), .tvOS(.v11), .watchOS(.v4), .driverKit(.v19)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SignalUI",
            targets: ["SignalUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Signals", path: "../Signals"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SignalUI",
            dependencies: []),
        .testTarget(
            name: "SignalUITests",
            dependencies: ["SignalUI"]),
    ]
)
