
/// A constraint on the layout of a type, e.g., it is known to be a class,
/// or be trivial with a fixed size.
public enum LayoutConstraint {
  /// Provides a bound on the alignment
  public enum SizeBound {
    /// The type's exact size and alignment are unknown, but will be no more
    /// than the specified values.
    case atMost(size: Int, alignment: Int)

    /// The type's size and alignment are known to have precise values.
    case exactly(size: Int, alignment: Int)
  }

  /// The type is a class. If `native` is `true`, the type is known to be
  /// a native Swift class (i.e., not an Objective-C class).
  case `class`(native: Bool)

  /// The type is a reference-counted point. If `native` is `true`, the type is
  /// known to use Swift's reference counting scheme (i.e., not Objective-C
  /// or foreign reference-counting schemes).
  case referenceCounted(native: Bool)

  /// The type is known to be trivial, meaning it can be memcpy'd and does not
  /// need to be destroyed. The optional bound provides more information about
  /// the size and alignment of the type, when available.
  case trivial(bound: SizeBound?)
}

/// A generic requirement that is part of the generic signature of a type,
/// e.g., `C: Collection` or `C.Element == C2.Element`.
public enum GenericRequirement {
  /// A type bound such as `C: Collection` or `T: SomeSuperclass`.
  case typeBound(Type, Type)

  /// A same-type constraint such as `C.Element == C2.Element`.
  case sameType(Type, Type)

  /// A same-shape constraint that ensures that two parameter packs have the
  /// same shape.
  ///
  /// Note: this does not have a spelling in the surface language.
  case sameShape(Type, Type)

  /// A layout constraint that states that a given type
  case layout(Type, LayoutConstraint)

  /// A pack expansion of a generic requirement, e.g.,
  /// `T.Element = U.Element...`.
  ///
  /// Note: this might not be part of the variadic generics proposal.
  indirect case packExpansion(GenericRequirement)
}
