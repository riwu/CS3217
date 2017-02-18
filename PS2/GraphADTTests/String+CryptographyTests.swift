//
//  String+CryptographyTests.swift
//  GraphADT
//
//  Created by riwu on 22/1/17.
//  Copyright © 2017 NUS CS3217. All rights reserved.
//

import XCTest
@testable import GraphADT

class StringCryptographyTests: XCTestCase {
    
    func testEncipherWithKey() {
        let emptyCipher = " ".encipherWithKey(2)
        XCTAssertEqual(emptyCipher, " ")
        
        let cipherWithKeyAs2 = "HELLO WORLD".encipherWithKey(2)
        XCTAssertEqual(cipherWithKeyAs2, "HELOROLDL **W")
        
        let cipherWithKeyAs3 = "HELLO WORLD".encipherWithKey(3)
        XCTAssertEqual(cipherWithKeyAs3, "HEO WLORLLD")
        
        let cipherWithKeyAs4 = "HELLO WORLD".encipherWithKey(4)
        XCTAssertEqual(cipherWithKeyAs4, "HE WORLLD**L****O")
        
        let cipherWithKeyAs20 = "HELLO WORLD".encipherWithKey(20)
        XCTAssertEqual(cipherWithKeyAs20, "HELLO WORLD")
    }
    
    func testDecipherWithKey() {
        let emptyDecipher = " ".decipherWithKey(2)
        XCTAssertEqual(emptyDecipher, " ")
        
        let decipherWithKeyAs2 = "HELOROLDL **W".decipherWithKey(2)
        XCTAssertEqual(decipherWithKeyAs2, "HELLO WORLD")
        
        let decipherWithKeyAs3 = "HEO WLORLLD".decipherWithKey(3)
        XCTAssertEqual(decipherWithKeyAs3, "HELLO WORLD")
        
        let decipherWithKeyAs4 = "HE WORLLD**L****O".decipherWithKey(4)
        XCTAssertEqual(decipherWithKeyAs4, "HELLO WORLD")
        
        let decipherWithKeyAs20 = "HELLO WORLD".decipherWithKey(20)
        XCTAssertEqual(decipherWithKeyAs20, "HELLO WORLD")
    }
    
}
