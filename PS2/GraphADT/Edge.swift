// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 `Edge` represents an edge in a graph. An `Edge` is associated with a source
 Node, a destination Node and a non-negative cost (or weight). This means that
 `Edge` is a directed edge from the source to the destination.
 
 The representation invariants:
 - The weight is non-negative
 
 Similar to `Node`, `Edge` is a generic type with a type parameter `T` that is
 the type of a node's label.
 
 - Authors: CS3217
 - Date: 2017
 */
struct Edge<T: Hashable> {
    typealias N = Node<T>

    let source: N
    let destination: N
    private(set) var weight = 1.0

    /// Constructs an `Edge` from `source` to `destination` with the
    /// default cost of 1.0.
    /// - Parameters
    ///   - source: The source `Node`
    ///   - destination: The destination `Node`
    init(source: N, destination: N) {
        self.init(source: source, destination: destination, weight: 1.0)!
        _checkRep()
    }

    /// Constructs an `Edge` from `source` to `destination` with the
    /// cost of `weight`.
    /// - Parameters
    ///   - source: The source `Node`
    ///   - destination: The destination `Node`
    ///   - weight: The cost of the `Edge`
    init?(source: N, destination: N, weight: Double) {
        self.source = source
        self.destination = destination
        if weight < 0 {
            return nil
        }
        self.weight = weight
        _checkRep()
    }

    /// Returns an edge in the opposite direction with the same cost.
    func reverse() -> Edge<T> {
        return Edge(source: destination, destination: source, weight: weight)!
    }

    /// Checks the representation invariants.
    private func _checkRep() {
        assert(weight >= 0, "Edge's weight cannot be negative.")
    }
}

// MARK: Hashable
extension Edge : Hashable {
    var hashValue: Int {
        return source.hashValue ^ destination.hashValue ^ weight.hashValue
    }
}

/// Return true if `lhs` edge is equal to `rhs` edge.
func ==<Label>(lhs: Edge<Label>, rhs: Edge<Label>) -> Bool {
    return lhs.source == rhs.source
        && lhs.destination == rhs.destination
        && lhs.weight == rhs.weight
}
