//
//  DashboardViewController.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-15.
//

import UIKit

nonisolated enum DashboardSections: Hashable {
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
	
	typealias DiffableDataSource = UICollectionViewDiffableDataSource<DashboardSections, DashboardItem>
	typealias Snapshot = NSDiffableDataSourceSnapshot<DashboardSections, DashboardItem>
	
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
		//		collectionView.delegate = self
		
		
		
		collectionView.collectionViewLayout = makeLayout()
		
		
		let postNib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
		collectionView.register(postNib, forCellWithReuseIdentifier: "PostCollectionViewCell")
		
		let recipeNib = UINib(nibName: "RecipeCollectionViewCell", bundle: nil)
		collectionView.register(recipeNib, forCellWithReuseIdentifier: "RecipeCollectionViewCell")
		
		collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SectionHeaderView.elementKind, withReuseIdentifier: SectionHeaderView.identifier)
		
	}
	
	
	private func makeLayout() -> UICollectionViewCompositionalLayout {
		let layout = UICollectionViewCompositionalLayout {[weak self] index, enviroment in
			guard let`self` = self else { return nil }
			let ids = self.dataSource?.snapshot().sectionIdentifiers ?? []
			guard  ids.indices.contains(index) else { return nil }
			
			return getSectionFor(section: ids[index])
			
		}
		
		return layout
		
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

//extension DashboardViewController: UICollectionViewDelegateFlowLayout {
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		return CGSize(width: collectionView.bounds.width, height: 100)
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//		return CGSize(width: collectionView.bounds.width, height: 100)
//	}
//}


extension DashboardViewController {
	
	func getSectionFor(section: DashboardSections) -> NSCollectionLayoutSection {
		switch section {
		case .post:
			return createSection(itemWidth: .fractionalWidth(1/3),
								 itemHeight: .absolute(80),
								 groupWidth: .fractionalWidth(1),
								 groupHeight: .absolute(80),
								 interItemSpace: .fixed(10),
								 interGroupSpace: 10, sectionInsets: NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing:16)
			)
		case .recipe:
			return createSection(itemWidth: .fractionalWidth(1),
								 itemHeight: .absolute(170),
								 groupWidth: .fractionalWidth(1),
								 groupHeight: .absolute(170),
								 scrollBehaviour: .groupPagingCentered,
								 interGroupSpace: 10,
								 sectionInsets: NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing:16),
			)
			
		}
	}
	
	func createSection(itemWidth: NSCollectionLayoutDimension,
					   itemHeight: NSCollectionLayoutDimension,
					   groupWidth: NSCollectionLayoutDimension,
					   groupHeight: NSCollectionLayoutDimension,
					   scrollBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none,
					   interItemSpace:  NSCollectionLayoutSpacing = .fixed(0),
					   interGroupSpace: Double = 0,
					   sectionInsets: NSDirectionalEdgeInsets = .zero
					   
					   
	) -> NSCollectionLayoutSection {
		
		let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		group.interItemSpacing = interItemSpace
		let section = NSCollectionLayoutSection(group: group)
		
		section.orthogonalScrollingBehavior = scrollBehaviour
		
		section.interGroupSpacing = interGroupSpace
		
		section.contentInsets = sectionInsets
		
		return section
	}
	
	
}
