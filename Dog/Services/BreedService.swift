//
//  BreedService.swift
//  Dog
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

final class BreedService {
	// List all breed names without sub breeds.
	static func fetchAllBreeds() -> SignalProducer<[Dog], ResponseError> {
		return SignalProducer { observer, disposable in
			let apiPath = "breeds/list"
			disposable += DogHTTPClient.shared.request(method: .get, URLString: apiPath)
				.startWithResult { result in
					switch result {
					case .success(let jsonData, _):
						guard let responseModel = try? JSONDecoder().decode(BreedListResponseModel.self, from: jsonData) else {
							observer.send(error: ResponseError(errorType: .jsonSerializationError))
							return
						}
						var dogs: [Dog] = []
						responseModel.message.forEach {
							let dog = Dog(name: $0)
							dogs.append(dog)
						}
						observer.send(value: dogs)
						observer.sendCompleted()
					case .failure(let responseError):
						observer.send(error: responseError)
					}
			}
		}
	}
	// Returns an array of all the dog images from all the master breeds
	static func fetchBreedImages(breedName: String) -> SignalProducer<[URL], ResponseError> {
		return SignalProducer { observer, disposable in			
			let apiPath = "breed/\(breedName)/images"
			disposable += DogHTTPClient.shared.request(method: .get, URLString: apiPath)
				.startWithResult { result in
					switch result {
					case .success(let jsonData, _):
						guard let responseModel = try? JSONDecoder().decode(BreedImageResponseModel.self, from: jsonData) else {
							observer.send(error: ResponseError(errorType: .jsonSerializationError))
							return
						}
						var imageUrls: [URL] = []
						responseModel.message.forEach {
							guard let dogImageUrl = URL(string: $0) else {
								return
							}
							imageUrls.append(dogImageUrl)
						}
						observer.send(value: imageUrls)
						observer.sendCompleted()
					case .failure(let responseError):
						observer.send(error: responseError)
					}
			}
		}
	}
}
