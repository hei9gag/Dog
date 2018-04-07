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
	let dog: Property<Dog?>
	let dogs: Property<[Dog]>

	fileprivate(set) var currentImageIndex: Int = 0

	private let dogMutable = MutableProperty<Dog?>(nil)
	private let dogsMutable = MutableProperty<[Dog]>([])	
	private(set) var fetchDogAction: Action<Void, [Dog], ResponseError>
	private(set) var fetchDogImageAction: Action<String, [URL], ResponseError>

	init() {
		self.dog = Property(self.dogMutable)
		self.dogs = Property(self.dogsMutable)

		self.fetchDogAction = Action {
			BreedService.fetchAllBreeds()
		}

		self.fetchDogImageAction = Action { breedName in
			BreedService.fetchBreedImages(breedName: breedName)
		}

	}

	func getTitleForIndex(_ index: Int) -> String? {
		guard index < dogs.value.count else {
			return nil
		}
		return dogs.value[index].name.firstUppercased
	}

	func fetchDogs() -> Disposable? {
		return self.fetchDogAction.apply().startWithResult { [unowned self] result in
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

	func fetchBreedImage(breedName: String) -> Disposable? {

		if let dog = self.findDogBy(breedName: breedName),
			let dogImages = dog.imageUrls,
			!dogImages.isEmpty {
			self.dogMutable.value = dog
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
				self.dogMutable.value = dog
				self.currentImageIndex = 0
			case .failure(_):
				// TODO handle error case
				break
			}
		}
	}

	func getNextDogImage() -> URL? {
		guard let dogImages = self.dog.value?.imageUrls else {
			return nil
		}
		self.currentImageIndex += 1
		guard self.currentImageIndex < dogImages.count else {
			self.currentImageIndex = 0
			return dogImages[0]
		}
		return dogImages[self.currentImageIndex]
	}

	private func findDogBy(breedName: String) -> Dog? {
		guard !self.dogsMutable.value.isEmpty else {
			return nil
		}
		return self.dogsMutable.value.filter { (dog) -> Bool in dog.name.lowercased() == breedName.lowercased()}.first
	}
}
