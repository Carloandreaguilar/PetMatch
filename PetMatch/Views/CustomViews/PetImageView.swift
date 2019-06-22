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
    

}
