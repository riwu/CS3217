// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 The `PriorityQueue` accepts and maintains the array in an order specified by
 their priority. For example, a Minimum Priority Queue of integers will serve
 (poll) the smallest integer first.
 
 array with the same priority are allowed, and such array may be served in
 any order arbitrarily.
 
 `PriorityQueue` is a generic type with a type parameter `T` that has to be
 `Comparable` so that `T` can be compared.
 
 - Authors: CS3217
 - Date: 2017
 */
struct PriorityQueue<T: Comparable> {

    private var array = [T]()
    private let isLowerOrder: (T, T) -> Bool

    /// Creates either a Min or Max `PriorityQueue`. Defaults to `min = true`.
    /// - Parameter min: Whether to return smallest array first.
    init(min: Bool = true) {
        isLowerOrder = min ? (<) : (>)
    }

    /// Returns the index of the parent of the element
    private func getParentIndex(_ index: Int) -> Int {
        return (index - 1) / 2
    }

    /// Returns the index of the left child of the element
    private func getLeftChildIndex(_ index: Int) -> Int {
        return index * 2 + 1
    }

    /// Adds the element and shifts it up until heap property is satisfied
    mutating func add(_ item: T) {
        array.append(item)
        var currentIndex = array.count - 1
        var parentIndex = getParentIndex(currentIndex)

        while currentIndex > 0 && isLowerOrder(item, array[parentIndex]) {
            array[currentIndex] = array[parentIndex]
            currentIndex = parentIndex
            parentIndex = getParentIndex(currentIndex)
        }

        array[currentIndex] = item
    }

    /// Returns the currently highest priority element.
    /// - Returns: the element if not nil
    func peek() -> T? {
        return array.first
    }

    /// Shifts root node down to satisfy heap property
    private mutating func shiftRootDown() {
        var currentIndex = 0

        for _ in array {
            let leftChildIndex = getLeftChildIndex(currentIndex)
            let rightChildIndex = leftChildIndex + 1
            var lowerOrderIndex: Int

            if rightChildIndex < array.count && isLowerOrder(array[rightChildIndex], array[currentIndex]) {
                lowerOrderIndex = rightChildIndex
            } else if leftChildIndex < array.count && isLowerOrder(array[leftChildIndex], array[currentIndex]) {
                lowerOrderIndex = leftChildIndex
            } else {
                return
            }

            swap(&array[currentIndex], &array[lowerOrderIndex])
            currentIndex = lowerOrderIndex
        }
    }

    /// Removes and returns the highest priority element.
    /// Move the last node to root then shift it down until heap property is satisfied
    /// - Returns: the element if not nil
    mutating func poll() -> T? {
        guard !array.isEmpty else {
            return nil
        }

        guard array.count > 1 else {
            return array.removeLast()
        }

        let result = array.first
        array[0] = array.removeLast()
        shiftRootDown()
        return result

    }

    /// The number of array in the `PriorityQueue`.
    var count: Int {
        return array.count
    }

    /// Whether the `PriorityQueue` is empty.
    var isEmpty: Bool {
        return array.isEmpty
    }
}
