import SwiftTypeSystem

public struct Metadata: TypeProtocol, Layout {
  public typealias System = Runtime
  typealias Layout = Kind

  let pointer: UnsafeRawPointer

  init(_ ptr: UnsafeRawPointer) {
    self.pointer = ptr
  }
}

extension Metadata {
  public var kind: Kind {
    layout
  }
}

extension Metadata {
  /// The structure of the type, which mirrors the spelling of the type as
  /// written in the language.
  public var structure: StructuralType<Metadata> {
    switch kind {
    case .tuple:
      let elts = TupleMetadata(pointer).map {
        TupleTypeElement<Runtime>(
          // We can technically dig this out from the labels string in tuple.
          name: nil,
          type: $0.type
        )
      }

      return .tuple(elts)

    default:
      return .placeholder
    }
  }
}
