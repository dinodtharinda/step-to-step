//
//  BasicDashboard.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-15.
//

import UIKit

class BasicDashboardViewController: DashboardViewController {
	let rs = RecipeService()
	
	var localRecipes: [Recipe] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchData()
	}

	override var dashboardTitle: String {
		return "Basic Dashboard"
	}
	
	override var recipes: [Recipe] {
		return localRecipes
	}
	
	func fetchData(){
		Task { [weak self] in
			guard let `self` = self else {
				return
			}
			localRecipes = await self.rs.fetchRecipes()
			applySnapshot()
			
		}
	}
}

