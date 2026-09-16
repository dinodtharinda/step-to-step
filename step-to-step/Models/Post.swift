//
//  Post.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-16.
//

import ObjectMapper

struct AllPost: Mappable {
	var posts: [Post] = []

	init?(map: Map){}
	
	mutating func mapping(map: Map) {
		posts <- map["posts"]
	}

}

struct Post: Mappable {
    var id: Int = 0
    var title: String = ""
    var body: String = ""
    var tags: [String] = []
    var reactions: Reactions?
    var views: Int = 0
    var userId: Int = 0

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id        <- map["id"]
        title     <- map["title"]
        body      <- map["body"]
        tags      <- map["tags"]
        reactions <- map["reactions"]
        views     <- map["views"]
        userId    <- map["userId"]
    }
}

struct Reactions: Mappable {
    var likes: Int = 0
    var dislikes: Int = 0

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        likes    <- map["likes"]
        dislikes <- map["dislikes"]
    }
}
