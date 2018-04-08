//
//  MockBreedService.swift
//  DogTests
//
//  Created by Brian Chung on 7/4/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

final class StubBreedService: BreedAPIProtocol {

	var fetchErrorForAllBreed: Bool = true

	func fetchAllBreeds() -> SignalProducer<[Dog], ResponseError> {

		guard !self.fetchErrorForAllBreed else {
			let responseError = ResponseError(errorType: .responseStatusError)			
			return SignalProducer(error: responseError)
		}

		let dogs = [
			Dog(name: "akita"),
			Dog(name: "hound"),
			Dog(name: "baka")
		]
		return SignalProducer(value: dogs)
	}

	func fetchBreedImages(breedName: String) -> SignalProducer<[URL], ResponseError> {

		guard breedName != "" else {
			let responseError = ResponseError(errorType: .responseStatusError)
			return SignalProducer(error: responseError)
		}

		let imageUrls = [
			URL(string:"https://dog.ceo/api/img/hound-Ibizan/n02091244_1000.jpg")!,
			URL(string:"https://dog.ceo/api/img/hound-Ibizan/n02091244_1025.jpg")!,
			URL(string:"https://dog.ceo/api/img/hound-Ibizan/n02091244_1030.jpg")!
		]
		return SignalProducer(value: imageUrls)
	}
}
