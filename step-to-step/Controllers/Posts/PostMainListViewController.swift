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
		setupDataSource()
		fetchData()
	}
	
	func setupCollectionView(){
		
		view.backgroundColor = .white
		
		let layout = makeLayout()
		
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



extension PostMainListViewController {
	
	
	private func makeLayout() -> UICollectionViewCompositionalLayout {
		let layout = UICollectionViewCompositionalLayout {[weak self] index , env in
			guard let `self` =  self else {
				return nil
			}
			let sections = dataSource?.snapshot().sectionIdentifiers ?? []
			
			guard sections.indices.contains(index) else { return nil }
			
			return getSectionFor(section: sections[index])
			
		}
		
		return layout
	}
	
	
	private func getSectionFor(section:PostMainSection)-> NSCollectionLayoutSection {
		
		switch section {
		case .post:
			return createSection(itemWidth: .fractionalWidth(1/2),
								 itemHeight: .absolute(100),
								 groupWidth: .fractionalWidth(1),
								 groupHeight: .absolute(100),
								 interItemSpace:.fixed(10),
								 interGroupSpace: 10,
								 sectionInsets: NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
		}
		
	}
	
	private func createSection(
		itemWidth: NSCollectionLayoutDimension,
		itemHeight: NSCollectionLayoutDimension,
		groupWidth: NSCollectionLayoutDimension,
		groupHeight: NSCollectionLayoutDimension,
		interItemSpace: NSCollectionLayoutSpacing = .fixed(0),
		interGroupSpace: Double = 0,
		scrollBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none,
		sectionInsets: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutSection {
			let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
			
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			
			let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
			
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

			group.interItemSpacing = interItemSpace
			
			
			let section = NSCollectionLayoutSection(group: group)
			
			section.interGroupSpacing = interGroupSpace
			
			section.orthogonalScrollingBehavior = scrollBehaviour
			
			section.contentInsets = sectionInsets
			
			return section
		}
}

import SwiftUI

#Preview {
	PostMainListViewController()
}

