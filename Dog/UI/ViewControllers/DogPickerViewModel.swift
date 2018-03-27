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

	private let dogsMutable = MutableProperty<[Dog]>([])
	private(set) var fetchDogAction: Action<Void, [Dog], ResponseError>

	init() {
		self.dogs = Property(self.dogsMutable)
		self.fetchDogAction = Action {
			BreedService.fetchAllBreeds()
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
}
