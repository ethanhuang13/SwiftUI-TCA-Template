import ComposableArchitecture
import Features
import XCTest

@MainActor
final class HomeFeatureTests: XCTestCase {
  func testTask() async throws {
    let store = TestStore(
      initialState: HomeFeature.State(),
      reducer: { HomeFeature() }
    ) {
      $0.apiClient.fetchNumber = { 13 }
    }

    await store.send(\.task)
    await store.receive(\.binding.number) {
      $0.number = 13
    }
  }
}
