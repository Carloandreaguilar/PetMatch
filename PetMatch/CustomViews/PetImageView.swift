//
//  PetImageView.swift
//  PetMatch
//
//  Created by Carlo Aguilar on 6/16/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit

class PetImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 7
         self.clipsToBounds = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
