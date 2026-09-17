//
//  SectionHeaderView.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-17.
//

import Foundation
import UIKit


class SectionHeaderView: UICollectionReusableView {
	static var identifier = "SectionHeaderView"
	static var elementKind = UICollectionView.elementKindSectionHeader
	
	private var icon = UIImageView()
	private var label = UILabel()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		alpha = 0.2
		
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.contentMode = .scaleAspectFit
		icon.tintColor = UIColor(named: "Title")
		addSubview(icon)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .black
		addSubview(label)
		
		
		NSLayoutConstraint.activate([
			icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
			icon.centerYAnchor.constraint(equalTo: centerYAnchor),
			icon.widthAnchor.constraint(equalToConstant: 3),
			icon.heightAnchor.constraint(equalToConstant: 20),
			
			label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
			label.centerYAnchor.constraint(equalTo: centerYAnchor),
			label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
		])
		
		
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func configure(icon:UIImage?, title:String){
		self.icon.image = icon
		self.icon.tintColor = .black
		label.textColor = .black
		label.text = title
	}
	
	
	
}
