import ComposableArchitecture
import Models

@Reducer
package struct HomeFeature {
  @ObservableState
  package struct State: Equatable {
    package init() {}
  }

  package enum Action: Equatable {
    case task
  }

  @Dependency(\.continuousClock) var clock

  package init() {}

  package var body: some ReducerOf<Self> {
    Reduce(core)
  }

  package func core(state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .task:
      return .none
    }
  }
}
