import SwiftTypeSystem

public struct Runtime: TypeSystem {
  public typealias Context = ()
  public typealias TypeRef = Metadata
  public typealias ResolvedNameBaggage = Never

  /// Bind the names of a type in the given context, resolving names to the
  /// kind of entity (and associated baggage) providing resolved names for each
  /// identifier.
  public func bind(_ type: TypeRef, in context: Context) -> TypeRef {
    type
  }

  /// Resolve a type in context, binding any names, checking generic arguments,
  /// and producing complete substitution maps (for example).
  ///
  /// Note: we need some way of producing errors.
  public func resolve(_ type: TypeRef, in context: Context) -> TypeRef {
    type
  }

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
  public func canonicalize(_ type: TypeRef, in context: Context) -> TypeRef {
    type
  }

  /// Apply the given set of `substitutions` to the provided `type`, replacing
  /// each occurrence of a generic parameter within the type with its
  /// corresponding generic argument.
  public func substitute(
    in type: TypeRef,
    with substitutions: SubstitutionMap<Self>
  ) -> TypeRef {
    type
  }
}
