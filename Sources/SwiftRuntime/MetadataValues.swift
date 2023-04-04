extension Metadata {
  public struct Kind {
    let value: Int

    init(_ value: Int) {
      self.value = value
    }

    static var isRuntimePrivate: Int {
      0x100
    }

    static var isNonHeap: Int {
      0x200
    }

    static var isNonType: Int {
      0x400
    }

    public static var `class`: Kind {
      Kind(0x0)
    }

    public static var `struct`: Kind {
      Kind(0x0 | isNonHeap)
    }

    public static var `enum`: Kind {
      Kind(0x1 | isNonHeap)
    }

    public static var optional: Kind {
      Kind(0x2 | isNonHeap)
    }

    public static var foreignClass: Kind {
      Kind(0x3 | isNonHeap)
    }

    public static var foreignReferenceType: Kind {
      Kind(0x4 | isNonHeap)
    }

    public static var opaque: Kind {
      Kind(0x0 | isRuntimePrivate | isNonHeap)
    }

    public static var tuple: Kind {
      Kind(0x1 | isRuntimePrivate | isNonHeap)
    }

    public static var function: Kind {
      Kind(0x2 | isRuntimePrivate | isNonHeap)
    }

    public static var existential: Kind {
      Kind(0x3 | isRuntimePrivate | isNonHeap)
    }

    public static var metatype: Kind {
      Kind(0x4 | isRuntimePrivate | isNonHeap)
    }

    public static var objcClassWrapper: Kind {
      Kind(0x5 | isRuntimePrivate | isNonHeap)
    }

    public static var existentialMetatype: Kind {
      Kind(0x6 | isRuntimePrivate | isNonHeap)
    }

    public static var extendedExistential: Kind {
      Kind(0x7 | isRuntimePrivate | isNonHeap)
    }

    public static var heapLocalVariable: Kind {
      Kind(0x0 | isNonType)
    }

    public static var heapGenericLocalVariable: Kind {
      Kind(0x0 | isRuntimePrivate | isNonType)
    }

    public static var errorObject: Kind {
      Kind(0x1 | isRuntimePrivate | isNonType)
    }

    public static var task: Kind {
      Kind(0x2 | isRuntimePrivate | isNonType)
    }

    public static var job: Kind {
      Kind(0x3 | isRuntimePrivate | isNonType)
    }
  }
}

extension Metadata.Kind: Equatable {
  public static func ==(_ lhs: Metadata.Kind, _ rhs: Metadata.Kind) -> Bool {
    // On Darwin platforms, the metadata kind for class types is the ObjC isa
    // pointer value which is guaranteed to be >= 0x800.
    switch (lhs.value, rhs.value) {
    case (0x800..., 0x0):
      return true
    case (0x0, 0x800...):
      return true
    case (0x800..., 0x800...):
      return true
    default:
      return lhs.value == rhs.value
    }
  }
}
