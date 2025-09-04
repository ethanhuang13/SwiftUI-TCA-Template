import CustomDump
import Foundation
import Models
import Testing

@Suite("NumberTests")
struct NumberTests {
  @Test("Test number init with value")
  func testNumber() async throws {
    let sut: Number = 1

    expectNoDifference(sut, 1)
  }
}
