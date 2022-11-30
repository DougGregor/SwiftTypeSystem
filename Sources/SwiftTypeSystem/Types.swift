public typealias Identifier = String

public struct Type<System: TypeSystem> {
  public typealias TypeRef = Type<System>

  /// The structure of the type, which mirrors the spelling of the type as
  /// written in the language.
  public let structure: Structure

  /// Additional "baggage" that provides more information about the type being
  /// described, which can only be interpreted by the specific type system.
  public var baggage: System.TypeBaggage?
}

extension Type {
  /// The kind of type, which provides a complete description of the Swift
  /// type system.
  public enum Structure {
    /// A referenced to a named type.
    ///
    /// This represents any named type, like 'Set<T>', which always includes
    /// the name, but might also have the parent type (i.e., the type before
    /// the `.` in `A.B`) and generic arguments.
    ///
    /// - Parameters:
    ///   - parent: The parent of this type, i.e., the enclosing type that is
    ///     written before the `.`
    ///   - name: The name of the type.
    ///   - genericArguments: If present, the generic arguments provided in
    ///     angle brackets ('<...>').
    ///   - kind: If present, describes what kind of entity is referenced by the
    ///     name, i.e., a struct, generic parameter, associated type, and so on.
    ///   - substitutions: If present, the complete set of substitutions applied
    ///     to a generic type to produce a specialized type.
    indirect case named(
      parent: TypeRef?,
      name: Identifier,
      genericArguments: [TypeRef]?,
      kind: ResolvedName?,
      substitutions: SubstitutionMap<System>?
    )

    /// An optional type T?.
    indirect case optional(TypeRef)

    /// An array type [T].
    indirect case array(TypeRef)

    /// A dictionary type [K:V].
    indirect case dictionary(key: TypeRef, value: TypeRef)

    /// A function type (params) -> type.
    indirect case function(
      parameters: [FunctionTypeParameter],
      result: TypeRef,
      attributes: FunctionAttributes
    )

    /// A tuple type (T1, T2, ..., TN), including a parenthesized type (T).
    indirect case tuple([TupleTypeElement<System>])

    /// A composition type A & B.
    indirect case composition([TypeRef])

    /// An existential type 'any P'.
    indirect case existential(TypeRef)

    /// An opaque type 'some P'.
    indirect case opaque(TypeRef)

    /// A pack expansion T....
    indirect case packExpansion(TypeRef)

    /// A metatype T.Type
    indirect case metatype(TypeRef)

    /// An existential metatype T.Protocol
    indirect case existentialMetatype(TypeRef)

    /// A placeholder type, spelled explicitly as '_'.
    ///
    /// This kind of type doesn't exist
    case placeholder

    /// An erroneous type, used in places where a type could not be determined.
    ///
    /// Note: compilers care deeply about this, because they need to be able
    /// to model errors at any point in the type hierarchy. However, it is
    /// inexpressible in the source language and most clients will deal with
    /// errors in a different way.
    case error

    /// An (unnamed generic parameter), which is identified by its "depth" (i.e.,
    /// the number of generic parameter lists in enclosing contexts) and "index"
    /// (the number of generic parameters preceding it in its generic parameter
    /// list).
    ///
    /// Note: this doesn't appear in the surface language, but is present in
    /// the compiler and in runtime metadata when working with canonical
    /// types and generic signatures.
    case genericParameter(depth: Int, index: Int)
  }
}
