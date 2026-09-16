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
	var localPosts: [Post] = []
	
	override var dashboardTitle: String {
		return "Pro Dashboard"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchPost()
	}
	
	override var posts: [Post] {
		return localPosts
	}
	
	func fetchPost(){
		Task { [weak self] in
			guard let `self` = self else {
				return
			}
			localPosts = await self.ps.fetchAllPost()
			self.collectionView.reloadData()
			
		}
		
	}
	
}
