//
//  DogPickerViewModel.swift
//  Dog
//
//  Created by Brian Chung on 27/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

final class DogPickerViewModel {
	let dogs: Property<[Dog]>
	let dogImages: Property<[URL]>

	fileprivate var currentImageIndex: Int = 0

	private let dogsMutable = MutableProperty<[Dog]>([])
	private let dogImagesMutable = MutableProperty<[URL]>([])
	private(set) var fetchDogAction: Action<Void, [Dog], ResponseError>
	private(set) var fetchDogImageAction: Action<String, [URL], ResponseError>

	init() {
		self.dogs = Property(self.dogsMutable)
		self.dogImages = Property(self.dogImagesMutable)

		self.fetchDogAction = Action {
			BreedService.fetchAllBreeds()
		}

		self.fetchDogImageAction = Action { breedName in
			BreedService.fetchBreedImages(breedName: breedName)
		}

		self.fetchDogAction.apply().startWithResult { [unowned self] result in
			switch result {
			case .success(let dogs):
				self.dogsMutable.value = dogs
				break
			case .failure(_):
				// TODO handle error case
				break
			}
		}
	}

	func getTitleForIndex(_ index: Int) -> String? {
		guard index < dogs.value.count else {
			return nil
		}
		return dogs.value[index].name.firstUppercased
	}

	func fetchBreedImage(breedName: String ) -> Disposable? {

		if let dog = self.findDogBy(breedName: breedName),
			let dogImages = dog.imageUrls,
			!dogImages.isEmpty {
			self.dogImagesMutable.value = dogImages
			self.currentImageIndex = 0
			return nil
		}

		return self.fetchDogImageAction.apply(breedName).startWithResult { [unowned self] result in
			switch result {
			case .success(let imageUrls):
				guard let dog = self.findDogBy(breedName: breedName) else {
					return
				}
				dog.imageUrls = imageUrls
				self.dogImagesMutable.value = imageUrls
				self.currentImageIndex = 0
			case .failure(_):
				// TODO handle error case
				break
			}
		}
	}

	func getNextDogImage() -> URL {
		self.currentImageIndex += 1		
		guard self.currentImageIndex < self.dogImages.value.count else {
			self.currentImageIndex = 0
			return self.dogImages.value[0]
		}
		return self.dogImages.value[self.currentImageIndex]
	}

	private func findDogBy(breedName: String) -> Dog? {
		guard !self.dogsMutable.value.isEmpty else {
			return nil
		}
		return self.dogsMutable.value.filter { (dog) -> Bool in dog.name.lowercased() == breedName.lowercased()}.first
	}
}
