
extension Type {
  /// The calling convention used for a function.
  public enum FunctionConvention {
    /// The normal Swift calling convention.
    ///
    /// This is the default calling convention for Swift functions, which is
    /// able to handle all Swift types and capture state.
    case swift

    /// The C calling convention, which can only use types expressible in
    /// (Objective-)C and cannot capture any state.
    case c

    /// The block calling convention, supporting the C "blocks" extension.
    ///
    /// These functions can only use types expressible in (Objective-)C, and
    /// can capture state.
    case block

    /// The normal Swift calling convention but without a context pointer.
    ///
    /// Thin functions can handle all Swift types, but are represented as a
    /// single function pointer and cannot capture state.
    case thin
  }

  /// Attributes provided for a function.
  public struct FunctionAttributes {
    /// Whether this function is asynchronous.
    public var `async`: Bool

    /// Whether this function can throw.
    public var `throws`: Bool

    /// Whether this function is escaping.
    public var `escaping`: Bool

    /// Whether this function is `@Sendable`.
    public var `sendable`: Bool

    /// The calling convention for the function.
    public var convention: FunctionConvention = .swift

    /// The global actor, such as `@MainActor`, on which this function runs.
    public var globalActor: Type?
  }

  /// The convention used to pass a parameter.
  public enum ParameterConvention {
    /// An `inout` parameter, which is passed indirectly and can be modified
    /// by the callee.
    case `inout`

    /// A borrowing parameter, which the callee cannot mutate.
    case borrowing

    /// A consuming parameter, which the callee can locally mutate and is
    /// responsible for destroying.
    case consuming
  }

  /// A parameter within a function type.
  public struct FunctionTypeParameter {
    /// The argument label used when calling the function.
    ///
    /// Note: this is in the language grammar, but must either be omitted or
    /// be `_`. We might not want to model this at all.
    public var argumentName: Identifier?

    /// The parameter name.
    ///
    /// Note: this is in the language grammar, but has no effect on anything.
    /// We might not want to model this at all.
    public var parameterName: Identifier?

    /// The parameter-passing convention, if specified.
    public var convention: ParameterConvention?

    /// Whether the parameter is variadic, i.e., `indices: Int...`.
    public var variadic: Bool

    // TODO: There are more bits here
  }
}
