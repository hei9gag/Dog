//
//  SignalProducer+Helper.swift
//  Dog
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

extension SignalProducerProtocol {
	func ignoreError() -> SignalProducer<Value, NoError> {
		return self.producer.flatMapError { _ in
			SignalProducer<Value, NoError>.empty
		}
	}
}

