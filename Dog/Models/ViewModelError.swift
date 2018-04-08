//
//  ViewModelError.swift
//  Dog
//
//  Created by Brian Chung on 8/4/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation

struct ViewModelError {
	var error: Error	
	var retryAction:(() -> Void)?
}
