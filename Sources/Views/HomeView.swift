import ComposableArchitecture
import Features
import SwiftUI

struct HomeView: View {
  let store: StoreOf<HomeFeature>

  init(store: StoreOf<HomeFeature>) {
    self.store = store
  }

  var body: some View {
    Text("Home", bundle: .module)
      .task {
        await store.send(.task).finish()
      }
  }
}

#Preview {
  HomeView(
    store: .init(
      initialState: .init(),
      reducer: {
        HomeFeature()
      }
    )
  )
}
