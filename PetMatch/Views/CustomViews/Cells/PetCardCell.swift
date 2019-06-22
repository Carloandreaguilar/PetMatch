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
  @IBOutlet weak var heartButton: UIButton!
  
  var lovePets: [Pet] = []
  var heartButtonState = false
  
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
  }
  
  
  @IBAction func heartButton(_ sender: Any) {
    if heartButtonState == false{
      self.heartButton.setImage(UIImage(named: "full_heart_icon"), for: .normal)
      self.heartButtonState = true
      
    } else {
      self.heartButton.setImage(UIImage(named: "outline_heart_icon"), for: .normal)
      self.heartButtonState = false
    }
  }
}
