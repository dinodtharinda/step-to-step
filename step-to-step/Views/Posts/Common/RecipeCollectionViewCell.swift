//
//  RecipeCollectionViewCell.swift
//  step-to-step
//
//  Created by Dinod Tharinda on 2026-09-17.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var lblTitle: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	

	
	func setupData(recipe:Recipe?){
		guard let r = recipe else {
			return
		}
		lblTitle.text = r.name
	}


}
