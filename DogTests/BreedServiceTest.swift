//
//  BreedServiceTest.swift
//  DogTests
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import XCTest
import Nimble
@testable import Dog

class BreedServiceTest: XCTestCase {

	let timeoutInterval: TimeInterval = 10

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchAllBreeds() {
		waitUntil(timeout: timeoutInterval, action: { done in
			BreedService.fetchAllBreeds()
				.ignoreError()
				.startWithValues { (dogs) in
					expect(dogs).notTo(beNil())
					expect(dogs.count) > 0
					done()
				}
		})
    }

	func testFetchBreedImages() {
		waitUntil(timeout: timeoutInterval, action: { done in
			BreedService.fetchBreedImages(breedName: "hound")
				.ignoreError()
				.startWithValues { (imageUrls) in
					expect(imageUrls).notTo(beNil())
					expect(imageUrls.count) > 0
					done()
			}
		})
	}

}
