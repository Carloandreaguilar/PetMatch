//
//  FloatingButton.swift
//  POCTodoList
//
//  Created by Carlo Andre Aguilar Castrat on 2/6/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class FloatingButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func disableRoundedCorners(){
        self.layer.cornerRadius = 0
    }
}
