//
//  DogHTTPClientTest.swift
//  DogTests
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import XCTest
import Nimble
@testable import Dog

class DogHTTPClientTest: XCTestCase {

	let timeoutInterval: TimeInterval = 10

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDogHTTPClient() {
		let urlRequestStr = "breeds/list"

		waitUntil(timeout: self.timeoutInterval, action: { done in
			DogHTTPClient.shared.request(method: .get, URLString: urlRequestStr).startWithResult { result in
				switch result {
				case .success(let jsonData, let httpHeader):
					expect(jsonData).notTo(beNil())
					expect(httpHeader).notTo(beNil())
				case .failure(_):
					fail("Expected result should response success")
				}
				done()
			}

		})
    }

}
