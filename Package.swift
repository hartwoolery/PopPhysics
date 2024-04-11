// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "PopPhysics",
    platforms: [.macOS(.v10_14)],
    products: [
        .library( name: "Box2D", targets: ["Box2D"] ),
        .library( name: "LiquidFun", targets: ["LiquidFun"] )
    ],
    targets: [
        .target( name: "Box2D" ),
        .target( name: "LiquidFun", dependencies:["Box2D"])
    ],
    
    cxxLanguageStandard: .cxx20
)


/*
 
    .target(name: "DLABridging", dependencies: ["DLABridgingCpp"], cxxSettings: headerPath),
    .target(name: "DLABridgingCpp", dependencies: ["DeckLinkAPI"]),
    .target(name: "DeckLinkAPI"),
 */
