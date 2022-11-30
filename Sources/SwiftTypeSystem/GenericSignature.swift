public struct GenericSignature<System: TypeSystem> {
  public var genericParameters: [GenericParameter<System>]
  public var requirements: [GenericRequirement<System>]
}
