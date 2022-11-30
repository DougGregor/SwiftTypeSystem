public struct SubstitutionMap<System: TypeSystem> {
  public let genericSignature: GenericSignature<System>
  public let genericArguments: [GenericArgument<System>]
}
