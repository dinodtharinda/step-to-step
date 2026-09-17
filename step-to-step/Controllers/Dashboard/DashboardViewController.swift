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
	
	var posts:[Post] {
		fatalError("initialize Posts")
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
		let nib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: "PostCollectionViewCell")
		
	}
}


extension DashboardViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return posts.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let post = posts[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
		cell.setupData(post: post)
		return cell
	}
	
	

}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 100)
	}
}


