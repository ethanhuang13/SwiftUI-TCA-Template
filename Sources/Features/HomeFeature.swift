import ComposableArchitecture
import DependencyClients
import Models

@Reducer
package struct HomeFeature {
  @ObservableState
  package struct State: Equatable {
    package var number: Number = 0

    package init() {}
  }

  package enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case task
  }

  package init() {}

  package var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce(core)
  }

  package func core(state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .binding:
      return .none
      
    case .task:
      return .run { send in
        @Dependency(\.apiClient) var apiClient
        let number = try await apiClient.fetchNumber()
        await send(.binding(.set(\.number, number)))
      }
    }
  }
}
