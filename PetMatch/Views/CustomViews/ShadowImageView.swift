//
//  ShadowImageView.swift
//  PetMatch
//
//  Created by Francesca Valeria Haro Dávila on 6/21/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//


import UIKit

@IBDesignable
class ShadowImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 0.1
    self.layer.shadowOffset = CGSize(width: 8, height: 8)
    self.layer.shadowRadius = 5
    self.layer.masksToBounds = false
  }
}
