public struct TupleMetadata: Layout {
  typealias Layout = (
    base: Metadata.Layout,
    numberOfElements: Int,
    labels: UnsafePointer<CChar>?
  )

  let pointer: UnsafeRawPointer

  init(_ ptr: UnsafeRawPointer) {
    self.pointer = ptr
  }
}

extension TupleMetadata: RandomAccessCollection {
  public struct Element {
    let storage: (Metadata, Int)

    public var type: Metadata {
      storage.0
    }

    public var offset: Int {
      storage.1
    }
  }

  public var startIndex: Int {
    0
  }

  public var endIndex: Int {
    layout.numberOfElements
  }

  public func index(after i: Int) -> Int {
    i + 1
  }

  public func index(before i: Int) -> Int {
    i - 1
  }

  public subscript(position: Int) -> Element {
    (trailing + position * MemoryLayout<Element>.size).load(as: Element.self)
  }
}
