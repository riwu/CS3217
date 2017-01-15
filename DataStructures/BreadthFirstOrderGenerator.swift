// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 A generator that returns the nodes in the graph in breadth-first search order,
 starting at the given node.

 - Authors: CS3217
 - Date: 2017
 */
struct BreadthFirstOrderGenerator<Key: Hashable, Value: Collection> : IteratorProtocol, Sequence where Value.Iterator.Element == Key {

    let graph : Dictionary<Key, Value>
    var nextNode : Key?
    var visitedNodes = Set<Key>()
    var queue = Queue<Key>() 
    
    /// Constructs a `BreadthFirstOrderGenerator` with the given graph and start
    /// node.
    /// - Parameters:
    ///   - graph: A dictionary of node to adjacency list pairs.
    ///   - start: The start node.
    init(graph: Dictionary<Key, Value>, start: Key) {
        self.graph = graph
        self.nextNode = start
    }
    
    func makeIterator() -> BreadthFirstOrderGenerator<Key, Value> {
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
  
    /// Returns the next node in BFS and sets the next node to visit in next call
    /// Use a queue to manage the visit order
    mutating func next() -> Key? {
        guard let result = nextNode else {
            return nil
        }
        visitedNodes.insert(result)
        queue.enqueue(result)
        while !visitNeighbour(node: try! queue.peek()) {
            _ = try! queue.dequeue()
            if queue.isEmpty {
                nextNode = nil
                break
            }
        }
        return result
    }
}
