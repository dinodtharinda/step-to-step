//
//  DashboardViewController.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-15.
//

import UIKit



nonisolated enum PostSections: Hashable {
	case post
}

class DashboardViewController: UIViewController {


	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!

	typealias DiffableDataSource = UICollectionViewDiffableDataSource<PostSections,Post>
	typealias Snapshot = NSDiffableDataSourceSnapshot<PostSections,Post>
	

	private var dataSource: DiffableDataSource?

	var dashboardTitle: String {
		fatalError("title should initilize on subclass")
	}

	var posts:[Post] {
		return []
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		lblTitle.text = dashboardTitle
		setupCollectionView()
		setupDataSource()
		applySnapshot()
	}

	private func setupCollectionView(){
		collectionView.delegate = self

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		collectionView.collectionViewLayout = layout
		let nib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
		collectionView.register(nib, forCellWithReuseIdentifier: "PostCollectionViewCell")

	}
	
	private func setupDataSource(){
		dataSource = DiffableDataSource(collectionView: collectionView){[weak self] collectionView, indexPath, postItem in
			guard let `self` =  self else {
				return UICollectionViewCell()
			}
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
			cell.setupData(post: postItem)
			return cell
		}
	}

	 func applySnapshot(animating: Bool = true){
		 guard let ds = dataSource else {
			 return
		 }
		
		var snapshot = Snapshot()
		snapshot.appendSections([.post])
		snapshot.appendItems(posts, toSection: .post)
		ds.apply(snapshot, animatingDifferences: false)
		
	}
	
}



extension DashboardViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 100)
	}
}

