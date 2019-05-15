//
//  PetImage.swift
//  PetMatch
//
//  Created by Carlo Andre Aguilar Castrat on 5/14/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit

class PetImage: NSObject {
    var image: UIImage?
    var key: String?

    init(key: String, image: UIImage) {
        self.image = image
        self.key = key
    }
}
