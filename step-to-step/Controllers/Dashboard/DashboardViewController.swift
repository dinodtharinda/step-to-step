//
//  DashboardViewController.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-15.
//

import UIKit

nonisolated enum PostSections: Hashable {
	case post
	case recipe
}

nonisolated enum DashboardItem: Hashable {
	case post(Post)
	case recipe(Recipe)
}

class DashboardViewController: UIViewController {

	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!

	typealias DiffableDataSource = UICollectionViewDiffableDataSource<PostSections, DashboardItem>
	typealias Snapshot = NSDiffableDataSourceSnapshot<PostSections, DashboardItem>

	private var dataSource: DiffableDataSource?

	var dashboardTitle: String {
		fatalError("title should initilize on subclass")
	}

	var posts: [Post] {
		return []
	}

	var recipes: [Recipe] {
		return []
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		lblTitle.text = dashboardTitle
		setupCollectionView()
		setupDataSource()
		applySnapshot()
	}

	private func setupCollectionView() {
		collectionView.delegate = self

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		
		collectionView.collectionViewLayout = layout
		
		
		let postNib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
		collectionView.register(postNib, forCellWithReuseIdentifier: "PostCollectionViewCell")
		
		let recipeNib = UINib(nibName: "RecipeCollectionViewCell", bundle: nil)
		collectionView.register(recipeNib, forCellWithReuseIdentifier: "RecipeCollectionViewCell")
		
		collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SectionHeaderView.elementKind, withReuseIdentifier: SectionHeaderView.identifier)
		
	}

	private func setupDataSource() {
		dataSource = DiffableDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, postItem in
			guard let `self` = self else {
				return UICollectionViewCell()
			}
			switch postItem {
			case .post(let posts):
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
				cell.setupData(post: posts)
				return cell
			case .recipe(let recipes):
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
				cell.setupData(recipe: recipes)
				return cell
			}
		}
		
		dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			guard let self,kind == SectionHeaderView.elementKind  else {
				return nil
			}
			
			let section = self.dataSource?.sectionIdentifier(for: indexPath.section)
			
			let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
			
			switch section {
			case .post:
				header.configure(icon: UIImage(named: "scanner.fill"), title: "POSTS")
			case .recipe:
				header.configure(icon: UIImage(named: "scanner.fill"), title: "RECIPES")
			case .none:
				header.configure(icon: UIImage(named: "scanner.fill"), title: "NO")
			}
			
			
			return header
			
		}
	}

	func applySnapshot(animating: Bool = true) {
		guard let ds = dataSource else {
			return
		}

		var snapshot = Snapshot()
		snapshot.appendSections([.post, .recipe])
		snapshot.appendItems(posts.map(DashboardItem.post),toSection: .post)
		snapshot.appendItems(recipes.map(DashboardItem.recipe), toSection: .recipe)
		
		ds.apply(snapshot, animatingDifferences: false)

	}

}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 100)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 100)
	}
}
