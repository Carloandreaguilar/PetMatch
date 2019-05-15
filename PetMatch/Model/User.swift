//
//  Owner.swift
//  PetMatch
//
//  Created by Carlo Aguilar on 2/9/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase

class User: NSObject {
  
  var name: String = ""
  var email: String = ""
  
  init(authData: Firebase.User) {
    name = authData.uid
    email = authData.email!
  }
  
  init(name: String, email: String) {
    self.name = name
    self.email = email
  }
}
