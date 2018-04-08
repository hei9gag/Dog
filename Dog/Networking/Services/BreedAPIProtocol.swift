//
//  BreedAPIProtocol.swift
//  Dog
//
//  Created by Brian Chung on 7/4/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol BreedAPIProtocol {
	func fetchAllBreeds() -> SignalProducer<[Dog], ResponseError>
	func fetchBreedImages(breedName: String) -> SignalProducer<[URL], ResponseError>
}
