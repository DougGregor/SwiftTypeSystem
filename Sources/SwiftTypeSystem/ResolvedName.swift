extension Type {
  /// Describes the role of
  public enum ResolvedName {
    /// A struct type.
    case `struct`

    /// An enum type.
    case `enum`

    /// An actor type.
    case `actor`

    /// A class type.
    case `class`

    /// A protocol type.
    case `protocol`

    /// An associated type.
    case associatedType

    /// A named generic parameter.
    case genericParameter

    /// A module.
    case module

    /// A typealias.
    case `typealias`

    /// The 'Self' type.
    case selfType
  }
}
