//
//  RecipeService.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-17.
//

import Foundation
import Alamofire

class RecipeService {
	var apiClient: APIClient
	
	init(apiClient: APIClient = APIClient()) {
		self.apiClient = apiClient
	}
	
	func fetchRecipes() async -> [Recipe] {
		do{
			let allRecipes = try await apiClient.fetechData(baseUrl: "https://dummyjson.com/", path: "recipes", method: .get) as AllRecipe
			return allRecipes.recipes
		} catch {
			print(error)
			return []
		}
	}
}
