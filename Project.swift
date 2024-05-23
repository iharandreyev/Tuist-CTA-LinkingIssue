import ProjectDescription

let project = Project(
    name: "Tuist-CTA-LinkingIssue",
    targets: [
        .target(
            name: "Tuist-CTA-LinkingIssue",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Tuist-CTA-LinkingIssue",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Tuist-CTA-LinkingIssue/Sources/**"],
            resources: ["Tuist-CTA-LinkingIssue/Resources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "Tuist-CTA-LinkingIssueTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.Tuist-CTA-LinkingIssueTests",
            infoPlist: .default,
            sources: ["Tuist-CTA-LinkingIssue/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Tuist-CTA-LinkingIssue")]
        ),
    ]
)
