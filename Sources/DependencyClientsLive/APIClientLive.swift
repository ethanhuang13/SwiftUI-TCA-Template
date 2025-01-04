import Dependencies
import DependenciesMacros
import DependencyClients

extension APIClient: DependencyKey {
  public static let liveValue = APIClient(
    fetchNumber: { 42 }
  )
}
