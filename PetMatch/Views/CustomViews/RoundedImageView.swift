//
//  RoundedImageView.swift
//  PetMatch
//
//  Created by Francesca Valeria Haro Dávila on 6/21/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = (self.frame.size.width) / 2;
    self.clipsToBounds = true
    self.layer.borderWidth = 3.0
    self.layer.borderColor = UIColor.white.cgColor
  }
  
  
}
