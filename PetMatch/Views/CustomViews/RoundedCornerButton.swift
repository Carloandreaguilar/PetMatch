//
//  RoundedCornerButton.swift
//  PetMatch
//
//  Created by Carlo Andre Aguilar Castrat on 2/14/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit

class RoundedCornerButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 3
        self.clipsToBounds = true
    }
}


