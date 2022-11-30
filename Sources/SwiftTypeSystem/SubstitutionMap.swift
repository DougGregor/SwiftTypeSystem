/// A substitution map describes a set of substitutions of generic arguments
/// for generic parameters that can be applied to types.
public struct SubstitutionMap<System: TypeSystem> {
  public let genericSignature: GenericSignature<System>
  public let genericArguments: [GenericArgument<System>]
}
