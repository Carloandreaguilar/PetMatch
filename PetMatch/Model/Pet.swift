//
//  Pet.swift
//  PetMatch
//
//  Created by Carlo Aguilar on 2/9/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase

class Pet: NSObject {
  var ref: DatabaseReference?
  var key: String
  var name: String
  var birthdate: String
  var about: String
  var gender: String
  var owner: String
  var type: String
  var photo: String
  
  
  init(key: String = "",type: String, name: String, birthdate: String, about: String, gender: String, owner: String, photo: String ) {
    self.ref = nil
    self.key = key
    self.name = name
    self.birthdate = birthdate
    self.about = about
    self.gender = gender
    self.owner = owner
    self.type = type
    self.photo = photo
  }
  
  
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: AnyObject],
      let name = value["Name"] as? String,
      let birthdate = value["Birthdate"] as? String,
      let about = value["About"] as? String,
      let gender = value["Genre"] as? String,
      let owner = value["Owner"] as? String,
      let type = value["Type"] as? String,
      let photo = value["Photo"] as? String else {
        return nil
    }
    self.ref = snapshot.ref
    self.key = snapshot.key
    self.name = name
    self.birthdate = birthdate
    self.about = about
    self.type = type
    self.gender = gender
    self.owner = owner
    self.photo = photo
  }
  
  func toAnyObject() -> Any {
    return [
      "Name": name,
      "Birthdate": birthdate,
      "About": about,
      "Genre": gender,
      "Owner": owner,
      "Type": type,
      "Photo": photo
    ]
  }
}
