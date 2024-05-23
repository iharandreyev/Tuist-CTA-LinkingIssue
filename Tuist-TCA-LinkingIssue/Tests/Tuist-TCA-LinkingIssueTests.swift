@testable import Tuist_CTA_LinkingIssue
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
