import ProjectDescription

let project = Project(
    name: "Tuist-TCA-LinkingIssue",
    targets: [
        .target(
            name: "Tuist-TCA-LinkingIssue",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Tuist-TCA-LinkingIssue",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Tuist-TCA-LinkingIssue/Sources/**"],
            resources: ["Tuist-TCA-LinkingIssue/Resources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "Tuist-TCA-LinkingIssueTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.Tuist-TCA-LinkingIssueTests",
            infoPlist: .default,
            sources: ["Tuist-TCA-LinkingIssue/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Tuist-TCA-LinkingIssue")]
        ),
    ]
)
