public enum GenericParameter<System: TypeSystem> {
  public typealias TypeRef = Type<System>

  /// A generic type parameter, e.g., <T>.
  case type(
    name: Identifier?,
    depth: Int,
    index: Int,
    baggage: System.ResolvedNameBaggage?
  )

  /// A parameter pack.
  indirect case parameterPack(GenericParameter<System>)
}
