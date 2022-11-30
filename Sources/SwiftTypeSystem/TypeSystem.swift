/// Describes the operations one can provide on types in the type system.
public protocol TypeSystem {
  /// A type-system-specific notion of a context, which is used to resolve
  /// information about types.
  associatedtype Context

  /// "Baggage" associated with any type reference, which provides additional
  /// information that is specific to the type system.
  associatedtype TypeBaggage: Hashable

  /// Baggage associated with a resolved name, which is used by the type
  /// system to refer to the underlying entity.
  associatedtype ResolvedNameBaggage: Hashable

  /// Bind the names of a type in the given context, resolving names to the
  /// kind of entity (and associated baggage) providing resolved names for each
  /// identifier.
  func bind(_ type: Type, in context: Context) -> Type

  /// Resolve a type in context, 
  ///
  /// Note: the
  func resolve(_ type: Type, in context: Context) -> Type

  /// Canonicalize a type in context, producing an equivalent type that
  /// reduces all syntactic sugar (including, e.g., type aliases,
  /// array/dictionary/optional sugar, parentheses).
  ///
  /// Comparing two canonicalized types for equality will determine whether the
  /// types are semantically equivalent in the type system.
  func canonicalize(_ type: Type, in context: Context) -> Type
}
