// Copyright (c) 2017 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class BreadthFirstOrderGeneratorTests: XCTestCase {

    func testCyclicGraph() {
        let graphFileName = "graph_cycle"
        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "A"),
            ["A", "B", "C", "D"],
            "The BFS for \(graphFileName) is wrong!")

        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "B"),
                       ["B", "D", "C"],
                       "The BFS for \(graphFileName) is wrong!")
    }

    func testLinkedListGraph() {
        let graphFileName = "graph_linkedlist"
        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "A"),
            ["A", "B", "C", "D", "E"],
            "The BFS for \(graphFileName) is wrong!")
    }

    func testExampleGraph() {
        let graphFileName = "graph_example"
        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "A"),
            ["A", "B", "C", "E", "D", "F", "G"],
            "The BFS for \(graphFileName) is wrong!")

        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "F"),
                       ["F", "B", "E", "A", "D", "C", "G"],
                       "The BFS for \(graphFileName) is wrong!")
    }

    func testExample2Graph() {
        let graphFileName = "graph_example2"
        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "H"),
                       ["H", "D", "C", "B", "A", "G", "F", "E"],
                       "The BFS for \(graphFileName) is wrong!")

        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "D"),
                       ["D", "B", "A", "F", "C", "E", "G"],
                       "The BFS for \(graphFileName) is wrong!")
    }

    func testNumberKeyGraph() {
        let graphFileName = "graph_numberkey"
        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: 1),
                       [1, 2, 5, 3, 7, 4, 9, 10, 8, 6],
                       "The BFS for \(graphFileName) is wrong!")

        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: 5),
                       [5, 4, 9, 3, 7, 10, 8, 6, 1, 2],
                       "The BFS for \(graphFileName) is wrong!")
    }

    private func getResultantNodesForGraph(_ fileName: String, startNode: String) -> [String] {
        // You do not need to modify this function.
        let path = Bundle.main.path(forResource: fileName, ofType: "plist")!
        let graph = NSDictionary(contentsOfFile: path)!
        let bfsGenerator = BreadthFirstOrderGenerator(graph: graph as! Dictionary<String, Array<String>>, start: startNode)

        var nodes = [String]()
        for node in bfsGenerator {
            nodes.append(node as String)
        }
        return nodes
    }

    private func getResultantNodesForGraph(_ fileName: String, startNode: Int) -> [Int] {
        let path = Bundle.main.path(forResource: fileName, ofType: "plist")!
        let graph = NSDictionary(contentsOfFile: path)!
        var graphWithIntKey = Dictionary<Int, Array<Int>>()
        for (key, value) in graph as! Dictionary<String, Array<Int>> {
            graphWithIntKey[Int(key)!] = value
        }
        let bfsGenerator = BreadthFirstOrderGenerator(graph: graphWithIntKey, start: startNode)

        var nodes = [Int]()
        for node in bfsGenerator {
            nodes.append(node as Int)
        }
        return nodes
    }
}
