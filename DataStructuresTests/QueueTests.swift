// Copyright (c) 2017 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class QueueTests : XCTestCase {

    func testEnqueue() {
        var queue = Queue<String>()
        queue.enqueue("1")
		queue.enqueue("3")
        queue.enqueue("2")
        XCTAssertEqual(queue.toArray(), ["1", "3", "2"], "The item is not enqueued correctly!")
    }

    func testDequeue() {
        var queue = Queue<String>()
        XCTAssertThrowsError(try queue.dequeue(), "Did not throw error when dequeuing empty queue!")
        queue.enqueue("1")
        queue.enqueue("2")
        let element = try? queue.dequeue()
        XCTAssertEqual(element, "1", "The item is not dequeued correctly!")
        XCTAssertEqual(queue.toArray(), ["2"], "The item is not dequeued correctly!")
    }

    func testPeek() {
        var queue = Queue<String>()
        XCTAssertThrowsError(try queue.peek(), "Did not throw error when peeking empty queue!")
        queue.enqueue("1")
        queue.enqueue("2")
        let element = try? queue.peek()
        XCTAssertEqual(element, "1", "The item peeked is not correct!")
        XCTAssertEqual(queue.toArray(), ["1", "2"], "Peeking altered the queue!")
    }

    func testCount() {
        var queue = Queue<String>()
        XCTAssertEqual(queue.count, 0, "The queue's length is not correct!");
        queue.enqueue("1")
        queue.enqueue("2")
        queue.enqueue("3")
        XCTAssertEqual(queue.count, 3, "The queue's length is not correct!");
    }

    func testIsEmpty() {
        var queue = Queue<String>()
        XCTAssertTrue(queue.isEmpty, "Queue incorrectly detected as non empty");
        queue.enqueue("1")
        XCTAssertFalse(queue.isEmpty, "Queue incorrectly detected as empty");
        _ = try? queue.dequeue()
        XCTAssertTrue(queue.isEmpty, "Queue incorrectly detected as non empty");
    }

    func testRemoveAll() {
        var queue = Queue<String>()
        queue.enqueue("1")
        queue.enqueue("2")
        queue.removeAll()
        XCTAssertTrue(queue.isEmpty, "Failed to remove all elements");
    }

    func testToArray() {
        var queue = Queue<String>()
        XCTAssertEqual(queue.toArray(), [], "toArray did not return correct array");
        queue.enqueue("1")
        queue.enqueue("3")
        queue.enqueue("2")
        XCTAssertEqual(queue.toArray(), ["1", "3", "2"], "toArray did not return correct array");
    }
}
