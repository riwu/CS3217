// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 Extension for `Tree` traversal.
 */
extension Tree {
    /// Returns an array that represents the tree when it is traversed
    /// in breadth-first order.
    /// - Returns: an array of all elements in the tree in breadth-first order
    func breadthFirstTraversal() -> [T] {
        return elements
    }

    /// Returns an array that represents the tree when it is traversed
    /// in depth-first order.
    /// - Returns: an array of all elements in the tree in depth-first order
    func depthFirstTraversal() -> [T] {
        var result = [T]()
        guard elements.count > 0 else {
            return result
        }

        var stack = [Int]()
        stack.append(0)
        while !stack.isEmpty {
            let last = stack.removeLast()
            result.append(elements[last])
            let leftMostChildIndex = numOfChildren * last + 1
            for i in (0..<numOfChildren).reversed() {
                let index = leftMostChildIndex + i
                if index < elements.count {
                    stack.append(index)
                }
            }
        }
        return result
    }
}
