// swift-tools-version: 5.10
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "swift-composable-architecture": .dynamicLibrary,
    ]
)
#endif

let package = Package(
    name: "Tuist-CTA-LinkingIssue",
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            "1.10.4" ..< "2.0.0"
        )
    ]
)
