// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 `Node` represents a vertex in a graph. `Node` is a generic type with a type
 parameter `T` that is the type of the node's label. For example, `Node<String>`
 is the type of nodes with a String label and `Node<Int>` is the type of nodes
 with a Int Label.
 
 Because we need to compare the node label, the type parameter `T` needs to
 conform to `Equatable` protocol.
 
 - Authors: CS3217
 - Date: 2017
 */
struct Node<T: Hashable> {
    let label: T

    /// Creates a `Node` with the given `label`.
    init(_ label: T) {
        self.label = label
    }
}

// MARK: Hashable
extension Node: Hashable {
    var hashValue: Int {
        return label.hashValue
    }
}

/// Return true if `lhs` node is equal to `rhs` node.
func ==<T>(lhs: Node<T>, rhs: Node<T>) -> Bool {
    return lhs.label == rhs.label
}
