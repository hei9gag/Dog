//
//  ResponseModelTests.swift
//  DogTests
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import XCTest
import Nimble
@testable import Dog

class ResponseModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBreedListResponseModelParsing() {
		let jsonData = FileHelper.readFile(fileName: "breed-list", ofType: "json")

		guard let breedListResponse = try? JSONDecoder().decode(BreedListResponseModel.self, from: jsonData) else {
			fail("Unable to parse JSON")
			return
		}
		
		expect(breedListResponse).notTo(beNil())

		let dogsInJson = [
			"african",
			"airedale",
			"akita"
		]

		dogsInJson.forEach {
			expect(breedListResponse.message.contains($0)) == true
		}
    }

	func testBreedImageResponseModelParsing() {
		let jsonData = FileHelper.readFile(fileName: "breed-images", ofType: "json")

		guard let imageResponseModel = try? JSONDecoder().decode(BreedImageResponseModel.self, from: jsonData) else {
			fail("Unable to parse JSON")
			return
		}

		expect(imageResponseModel).notTo(beNil())

		let imagesInJson = [
			"https://dog.ceo/api/img/hound-Ibizan/n02091244_100.jpg",
			"https://dog.ceo/api/img/hound-Ibizan/n02091244_1000.jpg"
		]

		imagesInJson.forEach {
			expect(imageResponseModel.message.contains($0)) == true
		}
	}
}
