//
//  GraphTests.swift
//  GraphADT
//
//  Created by riwu on 21/1/17.
//  Copyright © 2017 NUS CS3217. All rights reserved.
//

import XCTest
@testable import GraphADT

class GraphTests: XCTestCase {

    func testInit() {
        let graph = Graph<Int>(isDirected: true)
        XCTAssertEqual(graph.nodes, [Node<Int>](), "Should start empty")
        XCTAssertEqual(graph.edges, [Edge<Int>](), "Should start empty")
    }

    func testAddNode() {
        let graph = Graph<Int>(isDirected: true)
        graph.addNode(Node(1))
        graph.addNode(Node(3))
        graph.addNode(Node(2))
        XCTAssertEqual(graph.nodes.sorted(by: {$0.label < $1.label}),
                       [Node(1), Node(2), Node(3)], "Failed to add nodes")
    }
    func testRemoveNode() {
        let graph = Graph<Int>(isDirected: true)
        graph.removeNode(Node(5))
        XCTAssertEqual(graph.nodes, [Node<Int>](), "Graph is not empty after removal!")
        graph.addNode(Node(1))
        graph.addNode(Node(3))
        graph.removeNode(Node(5))
        XCTAssertEqual(graph.nodes.sorted(by: {$0.label < $1.label}), [Node(1), Node(3)], "Node wrongly removed")

        graph.removeNode(Node(1))
        XCTAssertEqual(graph.nodes, [Node(3)], "Node wrongly removed")

        graph.removeNode(Node(3))
        XCTAssertEqual(graph.nodes, [], "Node not removed")
    }

    func testContainsNode() {
        let graph = Graph<Int>(isDirected: true)
        graph.addNode(Node(1))
        XCTAssertTrue(graph.containsNode(Node(1)), "containsNode wrongly detected as false")
        XCTAssertFalse(graph.containsNode(Node(2)), "containsNode wrongly detected as true")
    }

    func testAddEdge() {
        guard let edge1 = Edge(source: Node(1), destination: Node(2), weight: 2.2),
              let edge2 = Edge(source: Node(3), destination: Node(4), weight: 1.2) else {
            XCTAssert(false, "Failed to initialise edge")
            return
        }

        let directedGraph = Graph<Int>(isDirected: true)
        directedGraph.addEdge(edge1)
        directedGraph.addEdge(edge2)
        XCTAssertEqual(directedGraph.nodes.sorted(by: {$0.label < $1.label}),
                       [Node(1), Node(2), Node(3), Node(4)], "Failed to add edge")
        XCTAssertEqual(directedGraph.edges.sorted(by: {$0.source.label < $1.source.label}),
                       [edge1, edge2], "Failed to add edge")

        directedGraph.addEdge(edge2)
        XCTAssertEqual(directedGraph.edges.sorted(by: {$0.source.label < $1.source.label}),
                       [edge1, edge2], "Failed to ignore already added edge")

        let undirectedGraph = Graph<Int>(isDirected: false)
        undirectedGraph.addEdge(edge1)
        undirectedGraph.addEdge(edge2)
        XCTAssertEqual(undirectedGraph.nodes.sorted(by: {$0.label < $1.label}),
                       [Node(1), Node(2), Node(3), Node(4)], "Failed to add edge")
        XCTAssertEqual(undirectedGraph.edges.sorted(by: {$0.source.label < $1.source.label}),
                       [edge1, edge1.reverse(), edge2, edge2.reverse()], "Failed to add edge")

        undirectedGraph.addEdge(edge2)
        XCTAssertEqual(undirectedGraph.edges.sorted(by: {$0.source.label < $1.source.label}),
                       [edge1, edge1.reverse(), edge2, edge2.reverse()], "Failed to ignore already added edge")
    }

    func testRemoveEdge() {
        guard let edge1 = Edge(source: Node(1), destination: Node(2), weight: 2.2),
              let edge2 = Edge(source: Node(3), destination: Node(4), weight: 1.2) else {
            XCTAssert(false, "Failed to initialise edge")
            return
        }

        let directedGraph = Graph<Int>(isDirected: true)
        directedGraph.addEdge(edge1)
        directedGraph.addEdge(edge2)
        directedGraph.removeEdge(edge1)
        XCTAssertEqual(directedGraph.nodes.sorted(by: {$0.label < $1.label}),
                       [Node(1), Node(2), Node(3), Node(4)], "Removing edge removed nodes too")
        XCTAssertEqual(directedGraph.edges.sorted(by: {$0.source.label < $1.source.label}),
                       [edge2], "Failed to remove edge")

        directedGraph.removeEdge(edge1)
        XCTAssertEqual(directedGraph.edges.sorted(by: {$0.source.label < $1.source.label}),
                       [edge2], "Failed to ignore already removed edge")

        let undirectedGraph = Graph<Int>(isDirected: false)
        undirectedGraph.addEdge(edge1)
        undirectedGraph.addEdge(edge2)
        undirectedGraph.removeEdge(edge1)
        XCTAssertEqual(undirectedGraph.nodes.sorted(by: {$0.label < $1.label}),
                       [Node(1), Node(2), Node(3), Node(4)], "Removing edge removed nodes too")
        XCTAssertEqual(undirectedGraph.edges.sorted(by: {$0.source.label < $1.source.label}),
                       [edge2, edge2.reverse()], "Failed to remove edge")

        undirectedGraph.removeEdge(edge1)
        XCTAssertEqual(undirectedGraph.edges.sorted(by: {$0.source.label < $1.source.label}),
                       [edge2, edge2.reverse()], "Failed to ignore already removed edge")
    }

    func testContainsEdge() {
        guard let edge = Edge(source: Node(1), destination: Node(2), weight: 2.2) else {
            XCTAssert(false, "Failed to initialise edge")
            return
        }

        let directedGraph = Graph<Int>(isDirected: true)
        directedGraph.addEdge(edge)
        XCTAssert(directedGraph.containsEdge(edge), "containsEdge wrongly detected as false")
        XCTAssertFalse(directedGraph.containsEdge(edge.reverse()), "containsEdge wrongly detected as true")

        let undirectedGraph = Graph<Int>(isDirected: false)
        undirectedGraph.addEdge(edge)
        XCTAssert(undirectedGraph.containsEdge(edge), "containsEdge wrongly detected as false")
        XCTAssert(undirectedGraph.containsEdge(edge.reverse()), "containsEdge wrongly detected as false")
    }

    func testEdgesFromNode() {
        guard let edge1 = Edge(source: Node(1), destination: Node(2), weight: 2.2),
              let edge2 = Edge(source: Node(1), destination: Node(2), weight: 1.2) else {
            XCTAssert(false, "Failed to initialise edge")
            return
        }

        let directedGraph = Graph<Int>(isDirected: true)
        directedGraph.addEdge(edge1)
        directedGraph.addEdge(edge2)
        XCTAssertEqual(directedGraph.edgesFromNode(Node(1), toNode: Node(2)).sorted(by: {$0.weight < $1.weight}),
                       [edge2, edge1], "edgesFromNode returned wrong edges")
        XCTAssertEqual(directedGraph.edgesFromNode(Node(2), toNode: Node(1)), [], "edgesFromNode returned wrong edges")

        let undirectedGraph = Graph<Int>(isDirected: false)
        undirectedGraph.addEdge(edge1)
        undirectedGraph.addEdge(edge2)
        XCTAssertEqual(undirectedGraph.edgesFromNode(Node(1), toNode: Node(2)).sorted(by: {$0.weight < $1.weight}),
                       [edge2, edge1], "edgesFromNode returned wrong edges")
        XCTAssertEqual(undirectedGraph.edgesFromNode(Node(2), toNode: Node(1)).sorted(by: {$0.weight < $1.weight}),
                       [edge2.reverse(), edge1.reverse()], "edgesFromNode returned wrong edges")
    }

    func testAdjacentNodesFromNode() {
        guard let edge1 = Edge(source: Node(1), destination: Node(2), weight: 2.2),
              let edge2 = Edge(source: Node(1), destination: Node(3), weight: 1.2) else {
            XCTAssert(false, "Failed to initialise edge")
            return
        }

        let directedGraph = Graph<Int>(isDirected: true)
        directedGraph.addEdge(edge1)
        directedGraph.addEdge(edge2)
        XCTAssertEqual(directedGraph.adjacentNodesFromNode(Node(1)).sorted(by: {$0.label < $1.label}),
                       [Node(2), Node(3)], "adjacentNodesFromNode returned wrong nodes")
        XCTAssertEqual(directedGraph.adjacentNodesFromNode(Node(2)), [], "adjacentNodesFromNode returned wrong nodes")

        let undirectedGraph = Graph<Int>(isDirected: false)
        undirectedGraph.addEdge(edge1)
        undirectedGraph.addEdge(edge2)
        XCTAssertEqual(undirectedGraph.adjacentNodesFromNode(Node(1)).sorted(by: {$0.label < $1.label}),
                       [Node(2), Node(3)], "adjacentNodesFromNode returned wrong nodes")
        XCTAssertEqual(undirectedGraph.adjacentNodesFromNode(Node(2)),
                       [Node(1)], "adjacentNodesFromNode returned wrong nodes")
    }
    
    func testAdjacentNodesFromNodeWithDuplicate() {
        guard let edge1 = Edge(source: Node(1), destination: Node(2), weight: 2.2),
            let edge2 = Edge(source: Node(1), destination: Node(2), weight: 1.2) else {
                XCTAssert(false, "Failed to initialise edge")
                return
        }
        
        let directedGraph = Graph<Int>(isDirected: true)
        directedGraph.addEdge(edge1)
        directedGraph.addEdge(edge2)
        XCTAssertEqual(directedGraph.adjacentNodesFromNode(Node(1)).sorted(by: {$0.label < $1.label}),
                       [Node(2)], "adjacentNodesFromNode returned wrong nodes")
        XCTAssertEqual(directedGraph.adjacentNodesFromNode(Node(2)), [], "adjacentNodesFromNode returned wrong nodes")
    }

    func testShortestPathFromNodeDirectedExample1() {
        guard let edge1 = Edge(source: Node(1), destination: Node(2), weight: 2.2),
              let edge2 = Edge(source: Node(1), destination: Node(3), weight: 5.2),
              let edge3 = Edge(source: Node(2), destination: Node(3), weight: 1.2) else {
            XCTAssert(false, "Failed to initialise edge")
            return
        }

        let directedGraph = Graph<Int>(isDirected: true)
        XCTAssertEqual(directedGraph.shortestPathFromNode(Node(1), toNode: Node(2)),
                       [], "adjacentNodesFromNode returned wrong nodes")
        directedGraph.addEdge(edge1)
        directedGraph.addEdge(edge2)
        directedGraph.addEdge(edge3)
        XCTAssertEqual(directedGraph.shortestPathFromNode(Node(1), toNode: Node(2)),
                       [edge1], "adjacentNodesFromNode returned wrong nodes")
        XCTAssertEqual(directedGraph.shortestPathFromNode(Node(1), toNode: Node(3)),
                       [edge1, edge3], "adjacentNodesFromNode returned wrong nodes")
    }

    func testShortestPathFromNodeDirectedExample2() {
        guard let edge1 = Edge(source: Node("A"), destination: Node("B"), weight: 4),
              let edge2 = Edge(source: Node("A"), destination: Node("C"), weight: 2),
              let edge3 = Edge(source: Node("B"), destination: Node("C"), weight: 5),
              let edge4 = Edge(source: Node("B"), destination: Node("D"), weight: 10),
              let edge5 = Edge(source: Node("C"), destination: Node("E"), weight: 3),
              let edge6 = Edge(source: Node("E"), destination: Node("D"), weight: 4),
              let edge7 = Edge(source: Node("D"), destination: Node("F"), weight: 11) else {
            XCTAssert(false, "Failed to initialise edge")
            return
        }
        let directedGraph = Graph<String>(isDirected: true)
        directedGraph.addEdge(edge1)
        directedGraph.addEdge(edge2)
        directedGraph.addEdge(edge3)
        directedGraph.addEdge(edge4)
        directedGraph.addEdge(edge5)
        directedGraph.addEdge(edge6)
        directedGraph.addEdge(edge7)
        XCTAssertEqual(directedGraph.shortestPathFromNode(Node("A"), toNode: Node("F")),
                       [edge2, edge5, edge6, edge7], "adjacentNodesFromNode returned wrong nodes")
    }

    func testShortestPathFromNodeUndirectedExample() {
        guard let edge1 = Edge(source: Node(1), destination: Node(2), weight: 2.2),
              let edge2 = Edge(source: Node(1), destination: Node(3), weight: 5.2),
              let edge3 = Edge(source: Node(2), destination: Node(3), weight: 1.2) else {
            XCTAssert(false, "Failed to initialise edge")
            return
        }

        let directedGraph = Graph<Int>(isDirected: false)
        XCTAssertEqual(directedGraph.shortestPathFromNode(Node(1), toNode: Node(2)),
                       [], "adjacentNodesFromNode returned wrong nodes")
        directedGraph.addEdge(edge1)
        directedGraph.addEdge(edge2)
        directedGraph.addEdge(edge3)
        XCTAssertEqual(directedGraph.shortestPathFromNode(Node(1), toNode: Node(2)),
                       [edge1], "adjacentNodesFromNode returned wrong nodes")
        XCTAssertEqual(directedGraph.shortestPathFromNode(Node(1), toNode: Node(3)),
                       [edge1, edge3], "adjacentNodesFromNode returned wrong nodes")
    }
}
