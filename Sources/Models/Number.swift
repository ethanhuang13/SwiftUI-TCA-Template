import Foundation

public struct Number: Equatable, Sendable {
  public var rawValue: Int
}

extension Number: ExpressibleByIntegerLiteral {
  public typealias IntegerLiteralType = Int

  public init(integerLiteral value: Int) {
    self.rawValue = value
  }
}
