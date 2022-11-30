/// A generic signature, which consists of both the generic parameters and
/// generic requirements on those parameters.
public struct GenericSignature<System: TypeSystem> {
  public var genericParameters: [GenericParameter<System>]
  public var requirements: [GenericRequirement<System>]
}
