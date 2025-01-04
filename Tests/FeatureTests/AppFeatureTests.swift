import ComposableArchitecture
import Features
import XCTest

@MainActor
final class AppFeatureTests: XCTestCase {
  func testTask() async throws {
    let store = TestStore(
      initialState: AppFeature.State(),
      reducer: {
        AppFeature()
      }
    )

    await store.send(.task)
  }
}
