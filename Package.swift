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
            targets: ["curry"]
        ),
    ],
    targets: [
        // curry is now entirely Swift. The sources still live in CurrySwift/,
        // which is where they landed while the library was half Objective-C.
        .target(
            name: "curry",
            path: "CurrySwift",
            resources: [
                .process("CurryImages.xcassets")
            ],
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
