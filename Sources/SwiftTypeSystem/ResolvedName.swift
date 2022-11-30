extension Type {
  /// Describes the role of
  public struct ResolvedName {
    public enum Kind {
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

    /// The kind of entity to which this name resolved.
    public let kind: Kind

    /// Additional baggage associated with the resolved name, which can
    /// only be meaningfully interpreted by the specific type system.
    public var baggage: System.ResolvedNameBaggage?
  }
}
