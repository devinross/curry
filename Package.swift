// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "curry",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "curry",
            targets: ["curry", "CurrySwift"]
        ),
    ],
    targets: [
        // Objective-C sources. Public headers are exposed through the flat
        // symlink directory `curry/include` so quoted imports resolve both
        // here and in the legacy framework targets.
        .target(
            name: "curry",
            path: "curry",
            exclude: [
                "Supporting Files/Info.plist",
            ],
            resources: [
                .process("Supporting Files/CurryImages.xcassets")
            ],
            publicHeadersPath: "include"
        ),
        // Swift-only extensions. SwiftPM targets can't mix Swift and
        // Objective-C, so these live in their own module.
        .target(
            name: "CurrySwift",
            path: "CurrySwift",
            swiftSettings: [
                .swiftLanguageMode(.v5)
            ]
        ),
        .testTarget(
            name: "curryTests",
            dependencies: ["curry"],
            path: "curryTests",
            exclude: [
                "Supporting Files"
            ]
        ),
    ]
)
