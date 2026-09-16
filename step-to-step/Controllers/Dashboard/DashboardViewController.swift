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
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		collectionView.collectionViewLayout = layout
		
	}
}


extension DashboardViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
		cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .systemBlue : .red
		return cell
	}
	
	

}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 100)
	}
}


