import ComposableArchitecture
import Features
import Testing

@MainActor
@Suite("HomeFeatureTests")
struct HomeFeatureTests {
  @Test("Test task fetches number")
  func testTask() async {
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
