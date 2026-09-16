//
//  PostService.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-16.
//

import Foundation
import Alamofire


class PostService {

	private let apiClient: APIClient
	
	init(apiClient: APIClient = APIClient()) {
		self.apiClient = apiClient
	}
	
	func fetchAllPost() async -> [Post] {
		
		do {
			let allpost = try await apiClient.fetechData(baseUrl: "https://dummyjson.com/",
														 path: "posts",
														 method: .get ,
														 parameters: nil,
														 headers: nil) as AllPost
			return allpost.posts
		} catch {
			print(error)
			return []
		}
		
	}
}
