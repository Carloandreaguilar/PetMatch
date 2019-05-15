//
//  LoveViewController.swift
//  PetMatch
//
//  Created by Francesca Valeria Haro Dávila on 2/22/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase

class LoveViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    Analytics.setScreenName("Love", screenClass: "LoveViewController")
  }
  

}


