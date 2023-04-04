protocol Layout {
  associatedtype Layout

  var pointer: UnsafeRawPointer { get }
}

extension Layout {
  var layout: Layout {
    pointer.load(as: Layout.self)
  }

  var trailing: UnsafeRawPointer {
    pointer + MemoryLayout<Layout>.size
  }
}
