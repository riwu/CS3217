// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 An enum of errors that can be thrown from the `Stack` struct.
 */
enum StackError: Error {
    /// Thrown when trying to access an element from an empty stack.
    case emptyStack
}

/**
 A generic `Stack` class whose elements are last-in, first-out.

 - Authors: CS3217
 - Date: 2017
 */
struct Stack<T> {
    var stack = [T]()
    /// Adds an element to the top of the stack.
    /// - Parameter item: The element to be added to the stack
    mutating func push(_ item: T) {
        stack.insert(item, at: 0)
    }

    /// Removes the element at the top of the stack and return it.
    /// - Returns: element at the top of the stack
    /// - Throws: StackError.EmptyStack
    mutating func pop() throws -> T {
        // TODO: Replace/remove the following line in your implementation.
        if isEmpty {
            throw StackError.emptyStack
        }
        return stack.remove(at: 0)
    }

    /// Returns, but does not remove, the element at the top of the stack.
    /// - Returns: element at the top of the stack
    /// - Throws: StackError.EmptyStack
    func peek() throws -> T {
        // TODO: Replace/remove the following line in your implementation.
        if isEmpty {
            throw StackError.emptyStack
        }
        return stack[0]
    }

    /// The number of elements currently in the stack.
    var count: Int {
        // TODO: Replace/remove the following line in your implementation.
        return stack.count
    }

    /// Whether the stack is empty.
    var isEmpty: Bool {
        // TODO: Replace/remove the following line in your implementation.
        return stack.isEmpty
    }

    /// Removes all elements in the stack.
    mutating func removeAll() {
        stack.removeAll()
    }

    /// Returns an array of the elements in their respective pop order, i.e.
    /// first element in the array is the first element to be popped.
    /// - Returns: array of elements in their respective pop order
    func toArray() -> [T] {
        // TODO: Replace/remove the following line in your implementation.
        return stack
    }
}