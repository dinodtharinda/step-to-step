//
//  DashboardViewController.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-15.
//

import UIKit

class DashboardViewController: UIViewController {


	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!
	
	
	var dashboardTitle: String {
		fatalError("title should initilize on subclass")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		lblTitle.text = dashboardTitle
		setupCollectionView()
	}
	
	private func setupCollectionView(){
		collectionView.delegate = self
		collectionView.dataSource = self
		let cell = UICollectionViewCell()
		
	}
}


extension DashboardViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
		cell.contentView.backgroundColor = .systemBlue
		return cell
	}
	
	

}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 100, height: 100)
	}
}


