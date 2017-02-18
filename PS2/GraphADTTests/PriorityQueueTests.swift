// Copyright (c) 2017 NUS CS3217. All rights reserved.

import XCTest
@testable import GraphADT

class PriorityQueueTests: XCTestCase {

    func testInit() {
        let pq = PriorityQueue<Int>()
        XCTAssertEqual(pq.count, 0, "Should start empty.")
        XCTAssertTrue(pq.isEmpty, "Should be empty.")
        XCTAssertNil(pq.peek(), "Should be None.")
    }

    func testAdd() {
        var pqMin = PriorityQueue<Int>()
        pqMin.add(0)
        pqMin.add(2)
        pqMin.add(1)
        XCTAssertEqual(pqMin.peek(), 0, "Failed to add correctly")
        XCTAssertEqual(pqMin.count, 3, "Failed to add correctly")

        var pqMax = PriorityQueue<Int>(min: false)
        pqMax.add(0)
        pqMax.add(2)
        pqMax.add(1)
        XCTAssertEqual(pqMax.peek(), 2, "Failed to add correctly")
        XCTAssertEqual(pqMax.count, 3, "Failed to add correctly")
    }

    func testPeek() {
        var pqMin = PriorityQueue<Int>()
        pqMin.add(1)
        XCTAssertEqual(pqMin.peek(), 1, "Failed to peek correctly")
        pqMin.add(2)
        XCTAssertEqual(pqMin.peek(), 1, "Failed to peek correctly")
        pqMin.add(0)
        XCTAssertEqual(pqMin.peek(), 0, "Failed to peek correctly")

        var pqMax = PriorityQueue<Int>(min: false)
        pqMax.add(1)
        XCTAssertEqual(pqMax.peek(), 1, "Failed to peek correctly")
        pqMax.add(2)
        XCTAssertEqual(pqMax.peek(), 2, "Failed to peek correctly")
        pqMax.add(0)
        XCTAssertEqual(pqMax.peek(), 2, "Failed to peek correctly")
    }

    func testPoll() {
        var pqMin = PriorityQueue<Int>()
        pqMin.add(0)
        XCTAssertEqual(pqMin.poll(), 0, "Failed to poll correctly")
        pqMin.add(2)
        pqMin.add(1)
        pqMin.add(3)
        XCTAssertEqual(pqMin.poll(), 1, "Failed to poll correctly")
        XCTAssertEqual(pqMin.poll(), 2, "Failed to poll correctly")
        XCTAssertEqual(pqMin.poll(), 3, "Failed to poll correctly")

        var pqMax = PriorityQueue<Int>(min: false)
        pqMax.add(0)
        XCTAssertEqual(pqMax.poll(), 0, "Failed to poll correctly")
        pqMax.add(2)
        pqMax.add(1)
        pqMax.add(3)
        XCTAssertEqual(pqMax.poll(), 3, "Failed to poll correctly")
        XCTAssertEqual(pqMax.poll(), 2, "Failed to poll correctly")
        XCTAssertEqual(pqMax.poll(), 1, "Failed to poll correctly")
    }

    func testCount() {
        var pq = PriorityQueue<Int>()
        pq.add(0)
        XCTAssertEqual(pq.count, 1, "Count failed")
        pq.add(2)
        pq.add(1)
        XCTAssertEqual(pq.count, 3, "Count failed")
        _ = pq.poll()
        XCTAssertEqual(pq.count, 2, "Count failed")
    }

    func testIsEmpty() {
        var pq = PriorityQueue<Int>()
        pq.add(0)
        XCTAssertFalse(pq.isEmpty, "isEmpty wrongly detected as empty")
        _ = pq.poll()
        XCTAssertTrue(pq.isEmpty, "isEmpty wrongly detected as non-empty")
    }
}
