// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 An enum of errors that can be thrown from the `Queue` struct.
 */
enum QueueError: Error {
    /// Thrown when trying to access an element from an empty queue.
    case emptyQueue
}


/**
 A generic `Queue` class whose elements are first-in, first-out.

 - Authors: CS3217
 - Date: 2017
 */
struct Queue<T> {
    /// Adds an element to the tail of the queue.
    /// - Parameter item: The element to be added to the queue
    mutating func enqueue(_ item: T) {
    }

    /// Removes an element from the head of the queue and return it.
    /// - Returns: item at the head of the queue
    /// - Throws: QueueError.EmptyQueue
    mutating func dequeue() throws -> T {
        // TODO: Replace/remove the following line in your implementation.
        throw QueueError.emptyQueue
    }

    /// Returns, but does not remove, the element at the head of the queue.
    /// - Returns: item at the head of the queue
    /// - Throws: QueueError.EmptyQueue
    func peek() throws -> T {
        // TODO: Replace/remove the following line in your implementation.
        throw QueueError.emptyQueue
    }

    /// The number of elements currently in the queue.
    var count: Int {
        // TODO: Replace/remove the following line in your implementation.
        return 0
    }

    /// Whether the queue is empty.
    var isEmpty: Bool {
        // TODO: Replace/remove the following line in your implementation.
        return false
    }

    /// Removes all elements in the queue.
    mutating func removeAll() {
    }

    /// Returns an array of the elements in their respective dequeue order, i.e.
    /// first element in the array is the first element to be dequeued.
    /// - Returns: array of elements in their respective dequeue order
    func toArray() -> [T] {
        // TODO: Replace/remove the following line in your implementation.
        return [T]()
    }
}