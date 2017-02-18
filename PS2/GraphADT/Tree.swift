// Copyright (c) 2017 NUS CS3217. All rights reserved.

/**
 The `Tree` ADT.
 Representative invariant:
 - The tree is complete, i.e. every level except possibly the last is completely filled,
   and all the nodes in the last level are as far left as possible
 - numOfChildren must be positive
 */
class Tree<T: Equatable> {

    private(set) var elements: [T]
    private(set) var numOfChildren: Int

    /// Initialise a complete tree with the given order and number of child nodes
    init(sequence: [T], numOfChildren: Int, breathFirstOrder: Bool) {
        self.numOfChildren = numOfChildren
        self.elements = sequence

        if !breathFirstOrder {
            depthFirstOrder(sequence)
        }
    }

    // Fill the tree in depth first order
    private func depthFirstOrder(_ sequence: [T]) {
        guard sequence.count > 0 else {
            return
        }

        var stack = [Int]()
        stack.append(0)
        for i in 0..<elements.count {
            assert(!stack.isEmpty)
            let last = stack.removeLast()
            elements[last] = sequence[i]
            let leftMostChildIndex = numOfChildren * last + 1
            for childIndexOffset in (0..<numOfChildren).reversed() {
                let index = leftMostChildIndex + childIndexOffset
                if index < sequence.count {
                    stack.append(index)
                }
            }
        }
    }
}
