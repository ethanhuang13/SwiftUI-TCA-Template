import ComposableArchitecture
import Features
import Testing

@MainActor
@Suite("AppFeatureTests")
struct AppFeatureTests {
  @Test("Test task action")
  func testTask() async {
    let store = TestStore(
      initialState: AppFeature.State(),
      reducer: {
        AppFeature()
      }
    )

    await store.send(.task)
  }
}
