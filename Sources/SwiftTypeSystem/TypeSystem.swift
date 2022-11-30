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

  /// A type within this type system.
  typealias TypeRef = Type<Self>

  /// Bind the names of a type in the given context, resolving names to the
  /// kind of entity (and associated baggage) providing resolved names for each
  /// identifier.
  func bind(_ type: TypeRef, in context: Context) -> TypeRef

  /// Resolve a type in context, binding any names, checking generic arguments,
  /// and producing complete substitution maps (for example).
  ///
  /// Note: we need some way of producing errors.
  func resolve(_ type: TypeRef, in context: Context) -> TypeRef

  /// Canonicalize a type in context, producing an equivalent type that
  /// reduces all syntactic sugar (including, e.g., type aliases,
  /// array/dictionary/optional sugar, parentheses, and so on).
  ///
  /// The canonical type produced from this operation is the language's notion
  /// of the type, which provides complete information for identifying the type
  /// independent of any context. A canonical type can be reasonably
  /// interpreted within any type system, without consulting system-specific
  /// baggage.
  ///
  /// Comparing two canonical types for equality determines whether
  /// the two types are semantic equivalent according to the language
  /// definition.
  func canonicalize(_ type: TypeRef, in context: Context) -> TypeRef
}
