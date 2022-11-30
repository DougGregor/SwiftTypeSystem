public enum GenericParameter<System: TypeSystem> {
  public typealias TypeRef = Type<System>

  /// A generic type parameter, e.g., <T>.
  ///
  /// A type parameter has an optional bound, i.e., `T: P`.
  case type(
    name: Identifier?,
    depth: Int,
    index: Int,
    bound: TypeRef?,
    baggage: System.ResolvedNameBaggage?
  )

  /// A parameter pack.
  indirect case parameterPack(GenericParameter<System>)
}
