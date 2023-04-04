public protocol TypeProtocol {
  associatedtype System: TypeSystem

  /// The structure of the type, which mirrors the spelling of the type as
  /// written in the language.
  var structure: StructuralType<Self> { get }
}

/// The kind of type, which provides a complete description of the Swift
/// type system.
public enum StructuralType<Type: TypeProtocol> {
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
  case named(
    parent: Type?,
    name: Identifier,
    genericArguments: [Type]?,
    kind: ResolvedName<Type.System>?,
    substitutions: SubstitutionMap<Type.System>?
  )

  /// An optional type T?.
  case optional(Type)

  /// An array type [T].
  case array(Type)

  /// A dictionary type [K:V].
  case dictionary(key: Type, value: Type)

  /// A function type (params) -> type.
  case function(
    parameters: [FunctionType<Type.System>.Parameter],
    result: Type,
    attributes: FunctionType<Type.System>.Attributes
  )

  /// A tuple type (T1, T2, ..., TN), including a parenthesized type (T).
  case tuple([TupleTypeElement<Type.System>])

  /// A composition type A & B.
  case composition([Type])

  /// An existential type 'any P'.
  case existential(Type)

  /// An opaque type 'some P'.
  case opaque(Type)

  /// A pack expansion T....
  case packExpansion(Type)

  /// A metatype T.Type
  case metatype(Type)

  /// An existential metatype T.Protocol
  case existentialMetatype(Type)

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
