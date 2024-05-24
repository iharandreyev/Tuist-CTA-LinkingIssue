#if canImport(Tuist_TCA_LinkingIssue)
@testable import Tuist_TCA_LinkingIssue
#endif

#if canImport(Tuist_TCA_LinkingIssue_Created_Manually)
@testable import Tuist_TCA_LinkingIssue_Created_Manually
#endif

import ComposableArchitecture
import Foundation
import XCTest

final class LinkingIssueSampleAppTests: XCTestCase {
    @MainActor
    func testReducer() async {
        let store = TestStoreOf<Feature>(
            initialState: .none,
            reducer: Feature.init
        )
        
        await store.send(.doSomething) { state in
            
        }
    }
}
