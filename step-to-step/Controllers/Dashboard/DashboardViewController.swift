//
//  DashboardViewController.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-15.
//

import UIKit

class DashboardViewController: UIViewController {
	@IBOutlet weak var lblTitle: UILabel!
	var dashboardTitle: String {
		fatalError("title should initilize on subclass")
	}
	
	override func viewDidLoad() {
		lblTitle.text = dashboardTitle
	}
}
