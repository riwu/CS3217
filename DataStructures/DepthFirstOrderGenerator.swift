// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 A generator that returns the nodes in the graph in depth-first search order,
 starting at the given node.

 - Authors: CS3217
 - Date: 2017
 */
struct DepthFirstOrderGenerator<Key: Hashable, Value: Collection> : IteratorProtocol, Sequence where Value.Iterator.Element == Key {

    let graph: Dictionary<Key, Value>
    var nextNode: Key?
    var visitedNodes = Set<Key>()
    var stack = Stack<Key>()

    /// Constructs a `DepthFirstOrderGenerator` with the given graph and start
    /// node.
    /// - Parameters:
    ///   - graph: A dictionary of node to adjacency list pairs.
    ///   - start: The start node.
    init(graph: Dictionary<Key, Value>, start: Key) {
        self.graph = graph
        self.nextNode = start
    }

    func makeIterator() -> DepthFirstOrderGenerator<Key, Value> {
        return self
    }

    /// Find an unvisited neighbour of node, add it to the visited set and set nextNode to it
    /// - Parameter node: The node to check for the neighbours
    /// - Returns: true if an unvisited neighbour is found
    mutating func visitNeighbour(node: Key) -> Bool {
        for neighbour in graph[node]! {
            if visitedNodes.insert(neighbour).inserted {
                nextNode = neighbour
                return true
            }
        }
        return false
    }

    /// Returns the next node in DFS and sets the next node to visit in next call
    /// Use a stack to manage the visit order
    mutating func next() -> Key? {
        guard let result = nextNode else {
            return nil
        }
        visitedNodes.insert(result)
        stack.push(result)
        while !visitNeighbour(node: try! stack.peek()) {
            _ = try! stack.pop()
            if stack.isEmpty {
                nextNode = nil
                break
            }
        }
        return result
    }
}
