// Copyright (c) 2017 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class StackTests: XCTestCase {

    func testPush() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(3)
        stack.push(2)
        XCTAssertEqual(stack.toArray(), [2, 3, 1], "The items are not pushed correctly!")
    }

    func testPop() {
        var stack = Stack<Int>()
        XCTAssertThrowsError(try stack.pop(), "Did not throw error when popping empty stack!")
        stack.push(1)
        stack.push(2)
        let element = try? stack.pop()
        XCTAssertEqual(element, 2, "The item is not popped correctly!")
        XCTAssertEqual(stack.toArray(), [1], "The item is not popped correctly!")
    }

    func testPeek() {
        var stack = Stack<Int>()
        XCTAssertThrowsError(try stack.peek(), "Did not throw error when peeking empty stack!")
        stack.push(1)
        stack.push(2)
        let element = try? stack.peek()
        XCTAssertEqual(element, 2, "The item peeked is not correct!")
        XCTAssertEqual(stack.toArray(), [2, 1], "Peeking altered the stack!")
    }

    func testCount() {
        var stack = Stack<Int>()
        XCTAssertEqual(stack.count, 0, "The stack's length is not correct!")
        stack.push(1)
        stack.push(2)
        stack.push(3)
        XCTAssertEqual(stack.count, 3, "The stack's length is not correct!")
    }

    func testIsEmpty() {
        var stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty, "Stack incorrectly detected as non empty")
        stack.push(1)
        XCTAssertFalse(stack.isEmpty, "Stack incorrectly detected as empty")
        _ = try? stack.pop()
        XCTAssertTrue(stack.isEmpty, "Stack incorrectly detected as non empty")
    }

    func testRemoveAll() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        stack.removeAll()
        XCTAssertTrue(stack.isEmpty, "Failed to remove all elements")
    }

    func testToArray() {
        var stack = Stack<Int>()
        XCTAssertEqual(stack.toArray(), [], "toArray did not return correct array")
        stack.push(1)
        stack.push(3)
        stack.push(2)
        XCTAssertEqual(stack.toArray(), [2, 3, 1], "toArray did not return correct array")
    }
}
