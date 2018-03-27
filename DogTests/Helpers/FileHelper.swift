//
//  FileHelper.swift
//  DogTests
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation
import Nimble

class FileHelper {
	static func readFile(fileName: String, ofType: String) -> Data {
		guard let filePath = Bundle(for: FileHelper.self).path(forResource: fileName, ofType: ofType) else {
			fatalError("Dummy json file not found")
		}

		guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .alwaysMapped) else {
			fatalError("Unable to read JSON data")
		}

		return data
	}
}
