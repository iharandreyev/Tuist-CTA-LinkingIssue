# Tuist-TCA-LinkingIssue

When using [Tuist 4.12.1](https://github.com/tuist/tuist/releases/tag/4.12.1) and linking [TCA](https://github.com/pointfreeco/swift-composable-architecture/tree/main) as `.staticFramework`, the following errors occured when running tests.

![Xcode Error](https://github.com/iharandreyev/Tuist-CTA-LinkingIssue/blob/main/Tuist-TCA-TestLinkingError.png?raw=true)

After updating to [Tuist 4.14.0](https://github.com/tuist/tuist/releases/tag/4.14.0), the aforementioned errors have gone away, but now runtime crashes started occuring.

TCA uses environment checks in runtime to determine which logic to use under the hood. For iOS 17 and upwards, it uses Apple's `ObservationRegistrar` to observe changes. For anything below -> `_PerceptionRegistrar`.

However there is an issue with these checks if the project is generated with tuist.

When instantiating the registrar, everything is going according to plan:

![PerceptionRegistrar.init](https://github.com/iharandreyev/Tuist-CTA-LinkingIssue/blob/main/PerceptionRegistrar.init.png?raw=true)

However, when trying to mutate the registrar, non-iOS 17 if branch is used, even though when inspecting app state through lldb, the picture is different:

![PerceptionRegistrar.withMutation](https://github.com/iharandreyev/Tuist-CTA-LinkingIssue/blob/main/PerceptionRegistrar.withMutation.png?raw=true)

Updating to [Tuist 4.1.15](https://github.com/tuist/tuist/releases/tag/4.15.0) does not help.
Changing product type to `.dynamicLibrary` does not help.
Linking TCA as project package instead of target dependency causes even more linking issues (similar to initial errors).
