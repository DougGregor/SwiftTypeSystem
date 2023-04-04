public struct TupleTypeElement<System: TypeSystem> {
  public var name: Identifier?
  public var type: System.TypeRef

  public init(name: Identifier?, type: System.TypeRef) {
    self.name = name
    self.type = type
  }
}
