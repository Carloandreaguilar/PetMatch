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
  
  
  @IBOutlet weak var loversTableView: UITableView!
  
  var lovers:[Pet] = []
  let loversTableViewCell = "LoversCell"
  let storage = Storage.storage()
  var user: User!
  let usersRef = Database.database().reference(withPath: "Users")
  let petRef = Database.database().reference(withPath: "Pets")
  let dateFormatter = DateFormatter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}



extension LoveViewController: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.lovers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: self.loversTableViewCell, for: indexPath) as? MyPetsTableViewCell else {
      return UITableViewCell()
    }
    
    let pet = lovers[indexPath.row]
    
    cell.petNameLabel.text = pet.name
    
    if FirebaseData.shared.allPetImages.count > indexPath.row{
      for petImage in FirebaseData.shared.allPetImages{
        if petImage.key == pet.key{
          cell.petImage.image = petImage.image
          break
        }
      }
      
      if cell.petImage.image == nil {
        let storageRef = FirebaseData.shared.storage.reference(forURL: pet.photo)
        storageRef.getData(maxSize: 10 * 1024 *  1024) { (data, error) -> Void in
          if let imgData = data {
            let pic = UIImage(data: imgData)
            cell.petImage.image = pic
            let petPic = PetImage(key: pet.key, image: pic ?? UIImage())
            FirebaseData.shared.allPetImages.append(petPic)
          }
        }
      }
    }
    else {
      let storageRef = FirebaseData.shared.storage.reference(forURL: pet.photo)
      storageRef.getData(maxSize: 10 * 1024 *  1024) { (data, error) -> Void in
        if let imgData = data {
          let pic = UIImage(data: imgData)
          cell.petImage.image = pic
          let petPic = PetImage(key: pet.key, image: pic ?? UIImage())
          FirebaseData.shared.allPetImages.append(petPic)
        }
      }
    }
    
    return cell
    
  }
}
