// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "PopPhysics",
    products: [
        .library(
            name: "Box2D",
            targets: ["Box2D"]
        )
    ],
    targets: [
        .target(
            name: "Box2D"
        )
    ],
    cxxLanguageStandard: .cxx20
)
