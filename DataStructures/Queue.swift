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
    var queue = [T]()
    /// Adds an element to the tail of the queue.
    /// - Parameter item: The element to be added to the queue
    mutating func enqueue(_ item: T) {
        queue.append(item)
    }

    /// Removes an element from the head of the queue and return it.
    /// - Returns: item at the head of the queue
    /// - Throws: QueueError.EmptyQueue
    mutating func dequeue() throws -> T {
        if queue.isEmpty {
            throw QueueError.emptyQueue
        }
        return queue.remove(at: 0)
    }

    /// Returns, but does not remove, the element at the head of the queue.
    /// - Returns: item at the head of the queue
    /// - Throws: QueueError.EmptyQueue
    func peek() throws -> T {
        if queue.isEmpty {
            throw QueueError.emptyQueue
        }
        return queue[0]
    }

    /// The number of elements currently in the queue.
    var count: Int {
        return queue.count
    }

    /// Whether the queue is empty.
    var isEmpty: Bool {
        return queue.isEmpty
    }

    /// Removes all elements in the queue.
    mutating func removeAll() {
        queue.removeAll()
    }

    /// Returns an array of the elements in their respective dequeue order, i.e.
    /// first element in the array is the first element to be dequeued.
    /// - Returns: array of elements in their respective dequeue order
    func toArray() -> [T] {
        return queue
    }
}
