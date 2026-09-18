//
//  PostMainListViewController.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-18.
//

import Foundation
import UIKit

nonisolated enum PostMainSection: Hashable{
	case post
}

nonisolated enum PostItem: Hashable{
	case post(Post)
}


class PostMainListViewController: UIViewController{
	
	typealias DataSource = UICollectionViewDiffableDataSource<PostMainSection,PostItem>
	typealias Snapshot = NSDiffableDataSourceSnapshot<PostMainSection,PostItem>
	
	private var ps = PostService()
	
	private var collectionView: UICollectionView!

	private var posts: [Post] = []
	
	private var dataSource: DataSource?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCollectionView()
	}
	
	func setupCollectionView(){
	
		view.backgroundColor = .white
		let layout = UICollectionViewFlowLayout()
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0)
		])
		
		// Register Cells
		let postNib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
		collectionView.register(postNib, forCellWithReuseIdentifier:  "PostCollectionViewCell")
		

	}
	
	private func fetchData(){
		Task{[weak self] in
			guard let `self` = self else {
				return
			}
			posts = await self.ps.fetchAllPost()
			applySnapshot()
		}
	}
	
	private func setupDataSource(){
		dataSource = DataSource(collectionView: collectionView){[weak self] collectionView,indexPath,postItem in
			guard let `self` = self else {
				return UICollectionViewCell()
			}
			
			switch postItem {
			case .post(let post):
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
				cell.setupData(post: post)
				return cell
			}
			
		}
	}
	
	private func applySnapshot(animating:Bool = true){
		guard let ds = dataSource else {
			return
		}
		
		var snapshot = Snapshot()
		snapshot.appendSections([.post])
		snapshot.appendItems(posts.map(PostItem.post),toSection: .post)
		
		ds.apply(snapshot, animatingDifferences: animating)
	}

}



