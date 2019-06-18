//
//  PetCardCell.swift
//  PetMatch
//
//  Created by Carlo Aguilar on 2/9/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit

@IBDesignable
class PetCardCell: UICollectionViewCell {
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var matchButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
//        self.layer.shadowRadius = 7
//        self.layer.shadowOffset = CGSize(width: 0, height: 15)
//        self.layer.shadowOpacity = 0.6
    }
    
}
