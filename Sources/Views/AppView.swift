import ComposableArchitecture
import Features
import SwiftUI

package struct AppView: View {
  let store: StoreOf<AppFeature>

  package init(store: StoreOf<AppFeature>) {
    self.store = store
  }

  package var body: some View {
    HomeView(store: store.scope(state: \.home, action: \.home))
      .task {
        await store.send(.task).finish()
      }
  }
}
