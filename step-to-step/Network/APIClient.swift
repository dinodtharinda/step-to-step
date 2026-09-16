//
//  APIClient.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-16.
//

import Foundation
import Alamofire
import ObjectMapper


class APIClient {
	func fetechData<T: Mappable>(baseUrl:String,
								 path:String,
								 method:HTTPMethod,
								 parameters: [String:Any]? = nil,
								 headers:HTTPHeaders? = nil,) async throws -> T {
		
		let data = try await AF.request(baseUrl + path, method: method, parameters: parameters, headers: headers)
			.serializingData()
			.value
		
		guard
			let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
			let object = Mapper<T>().map(JSON:json)
		else {
			fatalError("asdf")
		}
		return object
		
	}
}

