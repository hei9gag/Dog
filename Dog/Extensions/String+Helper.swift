//
//  String+Helper.swift
//  Dog
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation

extension String {
	var firstUppercased: String {
		guard let first = first else { return "" }
		return String(first).uppercased() + dropFirst()
	}
}
