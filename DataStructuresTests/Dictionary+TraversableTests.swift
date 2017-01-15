// Copyright (c) 2017 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class Dictionary_TraversableTests : XCTestCase {

    func testExampleGraph() {
        let graphFileName = "graph_example"
        let graph = getGraph(graphFileName) as! Dictionary<String, Array<String>>
        let nodeA = "A"
        
        var bfsGenerator = graph.breadthFirstOrderGeneratorFromNode(nodeA)
        XCTAssertEqual(bfsGenerator.next(), "A", "First node of bfs for \(graphFileName) from \(nodeA) should be 'A'!")
        XCTAssertEqual(bfsGenerator.next(), "B", "Second node of bfs for \(graphFileName) from \(nodeA) should be 'B'!")
        XCTAssertEqual(bfsGenerator.next(), "C", "Third node of bfs for \(graphFileName) from \(nodeA) should be 'C'!")
        XCTAssertEqual(bfsGenerator.next(), "E", "Fourth node of bfs for \(graphFileName) from \(nodeA) should be 'E'!")
        XCTAssertEqual(bfsGenerator.next(), "D", "Fifth node of bfs for \(graphFileName) from \(nodeA) should be 'D'!")
        XCTAssertEqual(bfsGenerator.next(), "F", "Sixth node of bfs for \(graphFileName) from \(nodeA) should be 'F'!")
        XCTAssertEqual(bfsGenerator.next(), "G", "Seventh node of bfs for \(graphFileName) from \(nodeA) should be 'G'!")
        
        let bfsNodes = graph.nodesSequenceInBreadthFirstOrderFromNode(nodeA)
        XCTAssertEqual(bfsNodes, ["A", "B", "C", "E", "D", "F", "G"],
            "The bfs for \(graphFileName) from \(nodeA) is wrong!")
        
        var dfsGenerator = graph.depthFirstOrderGeneratorFromNode(nodeA)
        XCTAssertEqual(dfsGenerator.next(), "A", "First node of dfs for \(graphFileName) from \(nodeA) should be 'A'!")
        XCTAssertEqual(dfsGenerator.next(), "B", "Second node of dfs for \(graphFileName) from \(nodeA) should be 'B'!")
        XCTAssertEqual(dfsGenerator.next(), "D", "Third node of dfs for \(graphFileName) from \(nodeA) should be 'D'!")
        XCTAssertEqual(dfsGenerator.next(), "F", "Fourth node of dfs for \(graphFileName) from \(nodeA) should be 'F'!")
        XCTAssertEqual(dfsGenerator.next(), "E", "Fifth node of dfs for \(graphFileName) from \(nodeA) should be 'E'!")
        XCTAssertEqual(dfsGenerator.next(), "C", "Sixth node of dfs for \(graphFileName) from \(nodeA) should be 'C'!")
        XCTAssertEqual(dfsGenerator.next(), "G", "Seventh node of dfs for \(graphFileName) from \(nodeA) should be 'G'!")
        
        let dfsNodes = graph.nodesSequenceInDepthFirstOrderFromNode(nodeA)
        XCTAssertEqual(dfsNodes, ["A", "B", "D", "F", "E", "C", "G"],
            "The dfs for \(graphFileName) from \(nodeA) is wrong!")
    }

    func testExample2Graph() {
        let graphFileName = "graph_example2"
        let graph = getGraph(graphFileName) as! Dictionary<String, Array<String>>
        let startNode = "H"
        
        var bfsGenerator = graph.breadthFirstOrderGeneratorFromNode(startNode)
        XCTAssertEqual(bfsGenerator.next(), "H", "First node of bfs for \(graphFileName) from \(startNode) should be 'H'!")
        XCTAssertEqual(bfsGenerator.next(), "D", "Second node of bfs for \(graphFileName) from \(startNode) should be 'D'!")
        XCTAssertEqual(bfsGenerator.next(), "C", "Third node of bfs for \(graphFileName) from \(startNode) should be 'C'!")
        XCTAssertEqual(bfsGenerator.next(), "B", "Fourth node of bfs for \(graphFileName) from \(startNode) should be 'B'!")
        XCTAssertEqual(bfsGenerator.next(), "A", "Fifth node of bfs for \(graphFileName) from \(startNode) should be 'A'!")
        XCTAssertEqual(bfsGenerator.next(), "G", "Sixth node of bfs for \(graphFileName) from \(startNode) should be 'G'!")
        XCTAssertEqual(bfsGenerator.next(), "F", "Seventh node of bfs for \(graphFileName) from \(startNode) should be 'F'!")
        XCTAssertEqual(bfsGenerator.next(), "E", "Seventh node of bfs for \(graphFileName) from \(startNode) should be 'E'!")

        let bfsNodes = graph.nodesSequenceInBreadthFirstOrderFromNode(startNode)
        XCTAssertEqual(bfsNodes, ["H", "D", "C", "B", "A", "G", "F", "E"],
                       "The bfs for \(graphFileName) from \(startNode) is wrong!")
        
        var dfsGenerator = graph.depthFirstOrderGeneratorFromNode(startNode)
        XCTAssertEqual(dfsGenerator.next(), "H", "First node of dfs for \(graphFileName) from \(startNode) should be 'H'!")
        XCTAssertEqual(dfsGenerator.next(), "D", "Second node of dfs for \(graphFileName) from \(startNode) should be 'D'!")
        XCTAssertEqual(dfsGenerator.next(), "B", "Third node of dfs for \(graphFileName) from \(startNode) should be 'B'!")
        XCTAssertEqual(dfsGenerator.next(), "A", "Fourth node of dfs for \(graphFileName) from \(startNode) should be 'A'!")
        XCTAssertEqual(dfsGenerator.next(), "C", "Fifth node of dfs for \(graphFileName) from \(startNode) should be 'C'!")
        XCTAssertEqual(dfsGenerator.next(), "G", "Sixth node of dfs for \(graphFileName) from \(startNode) should be 'G'!")
        XCTAssertEqual(dfsGenerator.next(), "E", "Seventh node of dfs for \(graphFileName) from \(startNode) should be 'E'!")
        XCTAssertEqual(dfsGenerator.next(), "F", "Seventh node of dfs for \(graphFileName) from \(startNode) should be 'F'!")

        let dfsNodes = graph.nodesSequenceInDepthFirstOrderFromNode(startNode)
        XCTAssertEqual(dfsNodes, ["H", "D", "B", "A", "C", "G", "E", "F"],
                       "The dfs for \(graphFileName) from \(startNode) is wrong!")
    }
    
    private func getGraph(_ fileName: String) -> NSDictionary {
        // You do not need to modify this function.
        let path = Bundle.main.path(forResource: fileName, ofType: "plist")!
        return NSDictionary(contentsOfFile: path)!
    }
}
