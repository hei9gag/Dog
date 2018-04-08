//
//  DogPickerViewModelTest.swift
//  DogTests
//
//  Created by Brian Chung on 28/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Nimble
import XCTest
import ReactiveCocoa
import ReactiveSwift
@testable import Dog

class DogPickerViewModelTest: XCTestCase {

	var viewModel: DogPickerViewModel!
	var apiService: StubBreedService!
	let timeoutInterval: TimeInterval = 10

    override func setUp() {
        super.setUp()
		self.apiService = StubBreedService()
		self.viewModel = DogPickerViewModel(apiService: self.apiService)
		let _ = self.viewModel.fetchDogs()
		waitUntil(timeout: timeoutInterval, action: { done in
			self.reactive.makeBindingTarget(on: UIScheduler(), { (_, dogs: [Dog]) in
				guard !dogs.isEmpty else {
					return
				}
				done()
				expect(dogs.count).to(beGreaterThan(0))
			}) <~ self.viewModel.dogs.skipRepeats { $0.count == $1.count }
		})
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testFetchDog() {
		self.apiService.fetchErrorForAllBreed = true

		waitUntil(timeout: timeoutInterval, action: { done in
			self.viewModel.fetchDogAction.apply().startWithFailed { (responseError) in
				expect(responseError).notTo(beNil())
				self.apiService.fetchErrorForAllBreed = false
				done()
			}
		})
	}

	func testFetchBreedImage() {
		let dogName = "akita"

		let _ = self.viewModel.fetchBreedImage(breedName: dogName)
		waitUntil(timeout: timeoutInterval, action: { done in
			self.reactive.makeBindingTarget(on: UIScheduler(), { (_, dog: Dog) in
				done()
				expect(dogName) == dog.name
				expect(dog.imageUrls).notTo(beNil())
				expect(dog.imageUrls!.count).to(beGreaterThan(0))
				expect(self.viewModel.currentImageIndex) == 0

				var dogImageUrl = self.viewModel.getNextDogImage()
				expect(self.viewModel.currentImageIndex) == 1
				expect(dogImageUrl!) == dog.imageUrls![self.viewModel.currentImageIndex]

				dogImageUrl = self.viewModel.getNextDogImage()
				expect(self.viewModel.currentImageIndex) == 2
				expect(dogImageUrl!) == dog.imageUrls![self.viewModel.currentImageIndex]
			}) <~ self.viewModel.dog.producer.skipNil()
		})
	}

	func testGetTitleForIndex() {
		var targetDogName = self.viewModel.dogs.value[0].name
		var result = self.viewModel.getTitleForIndex(0)
		expect(targetDogName.firstUppercased) == result

		targetDogName = self.viewModel.dogs.value[2].name
		result = self.viewModel.getTitleForIndex(2)
		expect(targetDogName.firstUppercased) == result

		result = self.viewModel.getTitleForIndex(9999)
		expect(result).to(beNil())
	}
}
