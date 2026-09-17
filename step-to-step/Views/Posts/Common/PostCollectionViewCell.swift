//
//  PostCollectionViewCell.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-17.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var lblTitle: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
    }
    
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	

	
	func setupData(post:Post?){
		guard let p = post else {
			return
		}
		lblTitle.text = p.title
	}

}
