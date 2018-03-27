//
//  Dog.swift
//  Dog
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation

class Dog {
	let name: String
	var imageUrls: [URL]?

	init(name: String) {
		self.name = name
		self.imageUrls = nil
	}
}
