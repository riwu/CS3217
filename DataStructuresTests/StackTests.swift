// Copyright (c) 2017 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class StackTests : XCTestCase {

    func testPush() {
        var stack = Stack<Int>()
        stack.push(1)

        XCTAssertEqual(stack.toArray(), [1], "The item is not pushed correctly!")
    }

    func testPop() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        let element = stack.pop()
        XCTAssertEqual(element, 2, "The item is not popped correctly!")
        XCTAssertEqual(stack.toArray(), [1], "The item is not popped correctly!")
    }

    func testPeek() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        let element = stack.peek()
        XCTAssertEqual(element, 2, "The item peeked is not correct!")
    }

    func testCount() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        XCTAssertEqual(stack.count, 3, "The stack's length is not correct!");
    }

    func testIsEmpty() {
        var stack = Stack<Int>()
        XCTAssertEqual(stack.isEmpty, true, "Stack incorrectly detected as non empty");
        stack.push(1)
        XCTAssertEqual(stack.isEmpty, false, "Stack incorrectly detected as empty");
    }

    func testRemoveAll() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        stack.removeAll()
        XCTAssertEqual(stack.isEmpty, true, "Failed to remove all elements");

    }

    func testToArray() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        XCTAssertEqual(stack.toArray(), [1, 2], "toArray did not return correct array")
    }
}
