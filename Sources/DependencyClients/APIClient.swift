import Dependencies
import DependenciesMacros
import Models

@DependencyClient
public struct APIClient: Sendable {
  public var fetchNumber: @Sendable () async throws -> Number
}

extension APIClient: TestDependencyKey {
  public static let testValue = Self()
}

extension DependencyValues {
  public var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}
