//
//  DogHTTPClient.swift
//  Network client for Dog API
//
//  Created by Brian Chung on 25/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift

final class DogHTTPClient {

	static let shared = DogHTTPClient()

	private init() {}

	private static var serviceBaseURLString: String {
		return "https://dog.ceo/api/"
	}

	private static var serviceBaseURL: URL {
		return URL(string: self.serviceBaseURLString)!
	}

	func request(method: HTTPMethod,
				 URLString: String,
				 parameters: Parameters? = nil,
				 parameterEncoding: ParameterEncoding? = nil,
				 contentType: String? = nil)
		-> SignalProducer<(jsonData: Data, headers: HTTPHeaders), ResponseError>
	{
		return ReactiveHTTPClient.shared.request(
			method: method,
			url: DogHTTPClient.serviceBaseURL.appendingPathComponent(URLString, isDirectory: false),
			parameters: parameters,
			parameterEncoding: parameterEncoding,
			contentType: contentType			
			).flatMap(.latest) { result, headers -> SignalProducer<(jsonData: Data, headers: HTTPHeaders), ResponseError> in
				guard let jsonData = result as? Data else {
					return SignalProducer(error: ResponseError(errorType: .unknownError(nil)))
				}
				
				do {
					guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any] else {
						return SignalProducer(error: ResponseError(errorType: .jsonSerializationError))
					}
					
					if let responseStatus = json["status"] as? ResponseStatusType,
						case .failure = responseStatus {
						return SignalProducer(error: ResponseError(errorType: .responseStatusError))
					}

				} catch let error {
					return SignalProducer(error: ResponseError.init(errorType: .unknownError(error as NSError)))
				}

				return SignalProducer(value: (jsonData, headers))
		}
	}
}
