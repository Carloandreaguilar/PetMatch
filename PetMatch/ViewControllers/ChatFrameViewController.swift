//
//  ChatFrameViewController.swift
//  PetMatch
//
//  Created by Francesca Valeria Haro Dávila on 6/19/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit

class ChatFrameViewController: UIViewController {

    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petIconChat: RoundedImageView!
    var name = ""
    var photo = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.petIconChat.image = self.photo
        self.petNameLabel.text = self.name
    }
    



}
