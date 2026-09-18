//
//  SplashViewController.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-15.
//

import UIKit

class SplashViewController: UIViewController{
	let isPro:Bool = true
	override func viewDidLoad() {
		print("Splash Loaded!")
		navigateToDashboard()
	}
	
	
	
	private func navigateToDashboard(){
//		if isPro {
//			let identifier = "ProDashboardViewController"
//			let sb = UIStoryboard(name: Constants.Storyboard.Dashboard.rawValue, bundle: nil)
//			let vc = sb.instantiateViewController(withIdentifier: identifier)
//			navigationController?.pushViewController(vc, animated: true)
//		} else {
//			let identifier = "BasicDashboardViewController"
//			let sb = UIStoryboard(name: Constants.Storyboard.Dashboard.rawValue, bundle: nil)
//			let vc = sb.instantiateViewController(withIdentifier: identifier)
//			navigationController?.pushViewController(vc, animated: true)
//		}

			let vc = PostMainListViewController()
			navigationController?.pushViewController(vc, animated: true)
		
	}
}
