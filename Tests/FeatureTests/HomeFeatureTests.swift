import XCTest
import ComposableArchitecture
import Features

@MainActor
final class HomeFeatureTests: XCTestCase {
  func testTask() async throws {
    let store = TestStore(initialState: HomeFeature.State()) {
      HomeFeature()
    }
    
    await store.send(.task)
  }
} 