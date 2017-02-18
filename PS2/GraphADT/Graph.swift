// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 The `Graph` ADT is able to represent the following graph types with
 corresponding constraints:
 - Undirected graph
 + An undirected edge is represented by 2 directed edges
 - Directed graph
 - Simple graph
 - Multigraph
 + Edges from the same source to the same destination should have
 different cost
 - Unweighted graph
 + Edges' weights are to set to 1.0
 - Weighted graph
 
 Hence, the representation invariants for every Graph g:
 - g is either directed or undirected
 - All nodes in g must have unique labels
 - Multiple edges from the same source to the same destination must
 not have the same weight
 
 Similar to `Node` and `Edge`, `Graph` is a generic type with a type parameter
 `T` that defines the type of the nodes' labels.
 
 - Authors: CS3217
 - Date: 2017
 */
class Graph<T: Hashable> {
    typealias N = Node<T>
    typealias E = Edge<T>

    private let isDirected: Bool
    private var adjacencyList = [N: Set<E>]()

    // 5 points:
    /// Constructs a direct or undirected graph.
    init(isDirected: Bool) {
        self.isDirected = isDirected

        _checkRep()
    }

    // 5 points:
    /// Adds the given node to the graph.
    /// If the node already exists in the graph, do nothing.
    func addNode(_ addedNode: N) {
        _checkRep()

        if adjacencyList[addedNode] == nil {
            adjacencyList[addedNode] = Set<E>()
        }

        _checkRep()
    }

    // 5 points:
    /// Remove the given node from the graph.
    /// If the node does not exist in the graph, do nothing.
    func removeNode(_ removedNode: N) {
        _checkRep()

        adjacencyList[removedNode] = nil
        for (node, edgeSet) in adjacencyList {
            for edge in edgeSet {
                if edge.destination == removedNode {
                    adjacencyList[node]!.remove(edge)
                }
            }
        }

        _checkRep()
    }

    // 5 points:
    /// Whether the graph contains the requested node.
    /// - Returns: true if the node exists in the graph
    func containsNode(_ targetNode: N) -> Bool {
        _checkRep()

        let result = adjacencyList[targetNode] != nil

        _checkRep()
        return result
    }

    // 5 points:
    /// Adds the given edge to the graph.
    /// If the edge already exists, do nothing. If any of the nodes referenced
    /// in the edge does not exist, it is added to the graph.
    func addEdge(_ addedEdge: E) {
        _checkRep()

        addNode(addedEdge.source)
        addNode(addedEdge.destination)
        adjacencyList[addedEdge.source]?.insert(addedEdge)
        if !isDirected {
            adjacencyList[addedEdge.destination]?.insert(addedEdge.reverse())
        }

        _checkRep()
    }

    // 5 points:
    /// Removes the requested edge from the graph. If it does not exist, do
    /// nothing.
    func removeEdge(_ removedEdge: E) {
        _checkRep()

        _ = adjacencyList[removedEdge.source]?.remove(removedEdge)
        if !isDirected {
            _ = adjacencyList[removedEdge.destination]?.remove(removedEdge.reverse())
        }

        _checkRep()
    }

    // 5 points:
    /// Whether the requested edge exists in the graph.
    /// - Returns: true if the requested edge exists.
    func containsEdge(_ targetEdge: E) -> Bool {
        _checkRep()

        let result = adjacencyList[targetEdge.source]?.contains(targetEdge) ?? false

        _checkRep()
        return result
    }

    // 5 points:
    /// Returns a list of edges directed from `fromNode` to `toNode`. If one of
    /// the nodes does not exist, returns an empty array.
    /// - Parameters:
    ///   - fromNode: the source `Node`
    ///   - toNode: the destination `Node`
    /// - Returns: an array of `Edge`s
    func edgesFromNode(_ fromNode: N, toNode: N) -> [E] {
        _checkRep()

        let edges = adjacencyList[fromNode]?.filter { edge in
            edge.destination == toNode
        }

        let result = edges ?? [E]()

        _checkRep()
        return result
    }

    // 5 points:
    /// Returns adjacent nodes of the `fromNode`, i.e. there is a directed edge
    /// from `fromNode` to its adjacent node. If the requested node does not
    /// exist, returns an empty array.
    /// - Parameters:
    ///   - fromNode: the source `Node`
    /// - Returns: an array of `Node`s
    func adjacentNodesFromNode(_ fromNode: N) -> [N] {
        _checkRep()

        var adjacentNodes = Set<N>()
        adjacencyList[fromNode]?.forEach { edge in
            adjacentNodes.insert(edge.destination)
        }

        _checkRep()
        return Array(adjacentNodes)
    }

    // 5 points (for `var nodes` and `var edges`):
    /// A read-only computed property that contains all the nodes
    /// of the graphs.
    var nodes: [N] {
        _checkRep()

        let result = Array(adjacencyList.keys)

        _checkRep()
        return result
    }

    /// A read-only computed property that contains all the edges
    /// of the graphs.
    var edges: [E] {
        _checkRep()

        let result = Array(adjacencyList.values.flatMap { $0 })

        _checkRep()
        return result
    }

    // 5 points:
    /// Checks the representation invariants of every Graph g.
    /// 1. g is either directed or undirected
    ///    - automatically true since isDirected is a Bool
    /// 2. All nodes in g must have unique labels
    ///	   - automatically true since nodes are stored in a dictionary
    /// 3. Multiple edges from the same source to the same destination
    ///    must not have the same weight
    ///    - since edges are stored in sets, we only need to make sure
    ///      every set is disjoint, by checking if the source node of every edge
    ///      matches the node (key) cooresponding to the edge set it is in.
    /// 4. Destination node of every edge exists
    /// 5. For undirected g, if there's an edge from A to B,
    ///    there must be an edge from B to A.
    private func _checkRep() {
        //3. ensures that every edge is in the set matching its source node
        for (node, edgeSet) in adjacencyList {
            for edge in edgeSet {
                assert(node == edge.source)
            }
        }

        for (_, edgeSet) in adjacencyList {
            for edge in edgeSet {
                let destSet = adjacencyList[edge.destination]
                assert(destSet != nil) // 4. check destination node of every edge exists
                if !isDirected { // 5. check for matching edge for undirected g
                    assert(destSet!.contains(edge.reverse()))
                }
            }
        }
    }

    //check graph is not multigraph (for shortest path function)
    private func _checkNotMultiGraph() {
        for (_, edgeSet) in adjacencyList {
            var adjacentNodes = Set<N>()
            for edge in edgeSet {
                assert(adjacentNodes.insert(edge.destination).inserted)
            }
        }
    }

    // 15 points:
    /// Returns the shortest path from `fromNode` to `toNode` assuming that the
    /// graph is not a multigraph.
    /// - Parameters:
    ///   - fromNode: the source `Node`
    ///   - toNode: the destination `Node`
    /// - Returns: a non-empty array of edges representing the shortest path
    /// order, if the two nodes are connected, an empty array otherwise
    func shortestPathFromNode(_ fromNode: N, toNode: N) -> [E] {
        _checkRep()
        _checkNotMultiGraph()

        var visitedNodes = Set<N>()
        var dist = [fromNode: 0.0]
        var prev = [N: E]()
        var pq = PriorityQueue<DistanceToSource<T>>()
        for node in nodes {
            if node != fromNode {
                dist[node] = .greatestFiniteMagnitude
            }
            pq.add(DistanceToSource(node: node, distance: dist[node]!))
        }
        while !pq.isEmpty {
            guard let lowestDist = pq.poll() else {
                assert(false)
            }
            if lowestDist.node == toNode {
                break
            }
            if !visitedNodes.insert(lowestDist.node).inserted {
                continue
            }
            for adjacentNode in adjacentNodesFromNode(lowestDist.node) {
                let edges = edgesFromNode(lowestDist.node, toNode: adjacentNode)
                assert(edges.count == 1)
                let edge = edges[0]
                let altDist = lowestDist.distance + edge.weight
                guard let currentDist = dist[adjacentNode] else {
                    assert(false)
                }
                if altDist >= currentDist {
					continue
                }
                dist[adjacentNode] = altDist
                prev[adjacentNode] = edge
                pq.add(DistanceToSource(node: adjacentNode, distance: altDist))
            }
        }
        var result = [E]()
        var currentNode = toNode
        repeat {
            guard let prevNode = prev[currentNode] else {
                break
            }
            result.append(prevNode)
            currentNode = prevNode.source
        } while currentNode != fromNode

        _checkRep()
        _checkNotMultiGraph()
        return result.reversed()
    }
}

private struct DistanceToSource<T: Hashable>: Comparable {
    let node: Node<T>
    let distance: Double

    static func <(lhs: DistanceToSource<T>, rhs: DistanceToSource<T>) -> Bool {
        return lhs.distance < rhs.distance
    }

    static func ==(lhs: DistanceToSource<T>, rhs: DistanceToSource<T>) -> Bool {
        return lhs.distance == rhs.distance
    }
}
