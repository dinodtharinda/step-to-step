//
//  ProDashboardViewController.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-15.
//

import Foundation
import UIKit


class ProDashboardViewController: DashboardViewController {
	let ps = PostService()
	let rs = RecipeService()
	var localPosts: [Post] = []
	var localRecipes: [Recipe] = []
	
	override var dashboardTitle: String {
		return "Pro Dashboard"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchData()
	}
	
	override var posts: [Post] {
		return localPosts
	}
	
	override var recipes: [Recipe] {
		return localRecipes
	}
	
	func fetchData(){
		Task { [weak self] in
			guard let `self` = self else {
				return
			}
			localPosts = await self.ps.fetchAllPost()
			applySnapshot()
			
		}
		
		Task {[weak self] in
			guard let `self` = self else {
				return
			}
			localRecipes = await self.rs.fetchRecipes()
			applySnapshot()
		
		}
		
	}
	
}
