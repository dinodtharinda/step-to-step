//
//  Recipe.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-17.
//

import Foundation

import ObjectMapper


struct AllRecipe: Mappable, Hashable {

	var recipes: [Recipe] = []
	init?(map: Map) { }

	mutating func mapping(map: Map) {
		recipes <- map["recipes"]
	}
}

struct Recipe: Mappable, Hashable {
    var id: Int?
    var name: String?
    var ingredients: [String]?
    var instructions: [String]?
    var prepTimeMinutes: Int?
    var cookTimeMinutes: Int?
    var servings: Int?
    var difficulty: String?
    var cuisine: String?
    var caloriesPerServing: Int?
    var tags: [String]?
    var userId: Int?
    var image: String?
    var rating: Double?
    var reviewCount: Int?
    var mealType: [String]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        ingredients         <- map["ingredients"]
        instructions        <- map["instructions"]
        prepTimeMinutes     <- map["prepTimeMinutes"]
        cookTimeMinutes     <- map["cookTimeMinutes"]
        servings            <- map["servings"]
        difficulty           <- map["difficulty"]
        cuisine              <- map["cuisine"]
        caloriesPerServing  <- map["caloriesPerServing"]
        tags                 <- map["tags"]
        userId              <- map["userId"]
        image               <- map["image"]
        rating              <- map["rating"]
        reviewCount         <- map["reviewCount"]
        mealType            <- map["mealType"]
    }
}
