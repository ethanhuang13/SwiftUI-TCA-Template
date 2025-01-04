import ComposableArchitecture
import DependencyClients
import DependencyClientsLive
import Features
import Models
import SwiftUI
import Views

@main
public struct PublicApp: App {
  public init() {}

  public var body: some Scene {
    WindowGroup {
      AppView(
        store: Store(
          initialState: AppFeature.State(),
          reducer: { AppFeature() }
        )
      )
    }
  }
}
