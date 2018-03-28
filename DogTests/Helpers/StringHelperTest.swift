//
//  StringHelperTest.swift
//  DogTests
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import XCTest
import Nimble
@testable import Dog

class StringHelperTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirstUppercased() {
		expect("african".firstUppercased) == "African"
		expect("aFrIcan".firstUppercased) == "AFrIcan"
		expect("AFRICAN".firstUppercased) == "AFRICAN"
    }
    
}
