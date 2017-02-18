// Copyright (c) 2017 NUS CS3217. All rights reserved.
import Foundation

extension String {
    
    private var specialChar: UnicodeScalar {
        return "*"
    }
    
    // Trim trailing special character from the chars
    // Side effect: trims leading special characters as well
    private func trimSpecialChar(_ chars: [Character]) -> String {
        return String(chars).trimmingCharacters(in: [specialChar])
    }
    
    /// Encrypts a string by using `key`.
    /// - Parameter key: an integer used for encryption, must be >= 2
    /// - Returns: the new encrypted string
    func encipherWithKey(_ key: Int) -> String {
        assert(key >= 2)
        let heightOfTree = ceil(log(Double(key - 1)) / log(Double(key)) + log(Double(self.characters.count)) / log(Double(key)) - 1)
        let numOfNodesOfPerfectTree = max((pow(Double(key), heightOfTree + 1) - 1) / Double(key - 1), Double(self.characters.count))
        let paddedStr = self.padding(toLength: Int(numOfNodesOfPerfectTree), withPad: String(specialChar), startingAt: 0)
        let tree = Tree<Character>(sequence: Array(paddedStr.characters), numOfChildren: key, breathFirstOrder: true)
        return trimSpecialChar(tree.depthFirstTraversal())
    }
    
    /// Decrypts a string by using `key`.
    /// - Parameter key: an integer used for decryption, must be >= 2
    /// - Returns: the new decrypted string
    func decipherWithKey(_ key: Int) -> String {
        assert(key >= 2)
        let tree = Tree<Character>(sequence: Array(self.characters), numOfChildren: key, breathFirstOrder: false)
        return trimSpecialChar(tree.breadthFirstTraversal())
    }
}
