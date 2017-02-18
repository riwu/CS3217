//
//  TreeTests.swift
//  GraphADT
//
//  Created by riwu on 22/1/17.
//  Copyright © 2017 NUS CS3217. All rights reserved.
//

import XCTest
@testable import GraphADT

class TreeTests: XCTestCase {
    
    func testInit() {
        let emptyTree = Tree<Int>(sequence: [], numOfChildren: 2, breathFirstOrder: true)
        XCTAssertEqual(emptyTree.elements, [])
        
        let allChildTree = Tree<Int>(sequence: [1, 2, 3, 4], numOfChildren: 10, breathFirstOrder: false)
        XCTAssertEqual(allChildTree.elements, [1, 2, 3, 4])
        
        let oneChildTree = Tree<Int>(sequence: [1, 2, 3, 4], numOfChildren: 1, breathFirstOrder: false)
        XCTAssertEqual(oneChildTree.elements, [1, 2, 3, 4])
        
        let intTree = Tree<Int>(sequence: [0, 1, 2, 3, 4, 5, 6], numOfChildren: 2, breathFirstOrder: true)
        XCTAssertEqual(intTree.elements, [0, 1, 2, 3, 4, 5, 6])
        
        let charTree = Tree<Character>(sequence: Array("HELOROLDL **W**".characters), numOfChildren: 2, breathFirstOrder: false)
        XCTAssertEqual(charTree.elements, Array("HELLO WORLD****".characters))
    }
    
    func testBreathFirstTraversal() {
        let emptyTree = Tree<Int>(sequence: [], numOfChildren: 2, breathFirstOrder: true)
        XCTAssertEqual(emptyTree.breadthFirstTraversal(), [])
        
        let allChildTree = Tree<Int>(sequence: [1, 2, 3, 4], numOfChildren: 10, breathFirstOrder: false)
        XCTAssertEqual(allChildTree.breadthFirstTraversal(), [1, 2, 3, 4])
        
        let oneChildTree = Tree<Int>(sequence: [1, 2, 3, 4], numOfChildren: 1, breathFirstOrder: false)
        XCTAssertEqual(oneChildTree.breadthFirstTraversal(), [1, 2, 3, 4])
        
        let intTree = Tree<Int>(sequence: [0, 1, 2, 3, 4, 5, 6], numOfChildren: 2, breathFirstOrder: true)
        XCTAssertEqual(intTree.breadthFirstTraversal(), [0, 1, 2, 3, 4, 5, 6])
        
        let charTree = Tree<Character>(sequence: Array("HELOROLDL **W**".characters), numOfChildren: 2, breathFirstOrder: false)
        XCTAssertEqual(charTree.breadthFirstTraversal(), Array("HELLO WORLD****".characters))
    }
    
    func testDepthFirstTraversal() {
        let emptyTree = Tree<Int>(sequence: [], numOfChildren: 2, breathFirstOrder: true)
        XCTAssertEqual(emptyTree.depthFirstTraversal(), [])
        
        let allChildTree = Tree<Int>(sequence: [1, 2, 3, 4], numOfChildren: 10, breathFirstOrder: false)
        XCTAssertEqual(allChildTree.depthFirstTraversal(), [1, 2, 3, 4])
        
        let oneChildTree = Tree<Int>(sequence: [1, 2, 3, 4], numOfChildren: 1, breathFirstOrder: true)
        XCTAssertEqual(oneChildTree.depthFirstTraversal(), [1, 2, 3, 4])
        
        let intTree = Tree<Int>(sequence: [0, 1, 2, 3, 4, 5, 6], numOfChildren: 2, breathFirstOrder: true)
        XCTAssertEqual(intTree.depthFirstTraversal(), [0, 1, 3, 4, 2, 5, 6])
        
        let depthFirstTreeWith2Child = Tree<Int>(sequence: [0, 1, 2, 3, 4, 5, 6], numOfChildren: 2, breathFirstOrder: false)
        XCTAssertEqual(depthFirstTreeWith2Child.depthFirstTraversal(), [0, 1, 2, 3, 4, 5, 6])
        
        let depthFirstTreeWith4Child = Tree<Int>(sequence: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], numOfChildren: 4, breathFirstOrder: false)
        XCTAssertEqual(depthFirstTreeWith4Child.depthFirstTraversal(), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        
        let charTree = Tree<Character>(sequence: Array("HELLO WORLD****".characters), numOfChildren: 2, breathFirstOrder: true)
        XCTAssertEqual(charTree.depthFirstTraversal(), Array("HELOROLDL **W**".characters))
    }
}
