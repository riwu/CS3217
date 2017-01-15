// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 A generator that returns the nodes in the graph in breadth-first search order,
 starting at the given node.

 - Authors: CS3217
 - Date: 2017
 */
struct BreadthFirstOrderGenerator<Key: Hashable, Value: Collection> : IteratorProtocol, Sequence where Value.Iterator.Element == Key {

    let graph : Dictionary<Key, Value>
    var currentNode : Key?
    var visitedNodes = Set<Key>()
    var queue = Queue<Key>()
    /// Constructs a `BreadthFirstOrderGenerator` with the given graph and start
    /// node.
    /// - Parameters:
    ///   - graph: A dictionary of node to adjacency list pairs.
    ///   - start: The start node.
    init(graph: Dictionary<Key, Value>, start: Key) {
        self.graph = graph
        self.currentNode = start
    }
    
    func makeIterator() -> BreadthFirstOrderGenerator<Key, Value> {
        return self
    }
    
    mutating func visitNeighbour(node: Key) -> Bool {
        for neighbour in graph[node]! {
            if visitedNodes.insert(neighbour).inserted {
                currentNode = neighbour
                return true
            }
        }
        return false
    }
    
    mutating func next() -> Key? {
        guard let result = currentNode else {
            return nil
        }
        visitedNodes.insert(result)
        queue.enqueue(result)
        while !visitNeighbour(node: try! queue.peek()) {
            _ = try! queue.dequeue()
            if queue.isEmpty {
                currentNode = nil
                break
            }
        }
        return result
    }
}
