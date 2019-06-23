//
//  HomeViewController.swift
//  PetMatch
//
//  Created by Francesca Valeria Haro Dávila on 2/8/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class HomeViewController: UIViewController {
  
  var selectedIndex = 0
    
  @IBOutlet weak var petCollectionView: UICollectionView!
  
  @IBAction func logOutAction(_ sender: UIBarButtonItem) {
    do {
      GIDSignIn.sharedInstance()?.signOut()
      try Auth.auth().signOut()
      
    }
    catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let initial = storyboard.instantiateInitialViewController()
    UIApplication.shared.keyWindow?.rootViewController = initial
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    FirebaseData.shared.updateData{
      DispatchQueue.main.async {
        self.petCollectionView.reloadData()
      }
    }
  }
  
  
  //    private var indexOfCellBeforeDragging = 0
  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return petCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  
  func calculateAgeFromDateString(dateString: String) -> DateComponents{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    let date: Date? = dateFormatter.date(from: dateString)
    let now = Date()
    let birthdate: Date = date ?? Date()
    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year, .month], from: birthdate, to: now)
    return ageComponents
  }
  
  func setImageFromURL(url: String){
    
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ChatFrameViewController {
            destinationViewController.name = FirebaseData.shared.allPets[self.selectedIndex].name
            destinationViewController.photo = FirebaseData.shared.allPetImages[self.selectedIndex].image ?? UIImage()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return FirebaseData.shared.allPets.count
  }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        if !FirebaseData.shared.matchedPets.contains(indexPath.row) {
            FirebaseData.shared.matchedPets.append(indexPath.row)
        }
        self.performSegue(withIdentifier: "chatSegue", sender: self)
    }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCardCell", for: indexPath) as? PetCardCell else {
      return UICollectionViewCell()
    }
    let pet = FirebaseData.shared.allPets[indexPath.row]
    cell.petImageView.image = nil
    cell.ageLabel.text = nil
    cell.nameLabel.text = nil
    cell.genderImageView.image = nil
    cell.activityIndicator.startAnimating()
    cell.nameLabel.text = pet.name
    cell.descriptionTextView.text = pet.about
    cell.genderImageView.image = UIImage(named: pet.gender)
    
    let ageComponents = self.calculateAgeFromDateString(dateString: pet.birthdate)
    switch ageComponents.year {
    case 0:
      switch ageComponents.month {
      case 0: cell.ageLabel.text = "Less than 1 month old"
      case 1: cell.ageLabel.text = "1 month old"
      default: cell.ageLabel.text = String(ageComponents.month ?? 0) + " months old"
      }
    case 1:
      cell.ageLabel.text = "1 year"
      switch ageComponents.month {
      case 0: cell.ageLabel.text = (cell.ageLabel.text ?? "") + " old"
      case 1: cell.ageLabel.text = (cell.ageLabel.text ?? "") + " and 1 month old"
      default: cell.ageLabel.text = (cell.ageLabel.text ?? "") + " and " + String(ageComponents.month ?? 0) + " months old"
      }
    default:
      cell.ageLabel.text = String(ageComponents.year ?? 0) + " years"
      switch ageComponents.month {
      case 0: cell.ageLabel.text = (cell.ageLabel.text ?? "") + " old"
      case 1: cell.ageLabel.text = (cell.ageLabel.text ?? "") + " and 1 month old"
      default: cell.ageLabel.text = (cell.ageLabel.text ?? "") + " and " + String(ageComponents.month ?? 0) + " months old"
      }
    }
    
    if FirebaseData.shared.allPetImages.count > indexPath.row{
      for petImage in FirebaseData.shared.allPetImages{
        if petImage.key == pet.key{
          cell.petImageView.image = petImage.image
          cell.activityIndicator.stopAnimating()
          break
        }
      }
      if cell.petImageView.image == nil {
        let storageRef = FirebaseData.shared.storage.reference(forURL: pet.photo)
        storageRef.getData(maxSize: 10 * 1024 *  1024) { (data, error) -> Void in
          if let imgData = data {
            let pic = UIImage(data: imgData)
            cell.petImageView.image = pic
            cell.activityIndicator.stopAnimating()
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
          cell.petImageView.image = pic
          cell.activityIndicator.stopAnimating()
          let petPic = PetImage(key: pet.key, image: pic ?? UIImage())
          FirebaseData.shared.allPetImages.append(petPic)
        }
      }
    }
    return cell
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.petCollectionView.collectionViewLayout = ZoomAndSnapFlowLayout(collectionViewFrame: self.petCollectionView.frame)
  }

}
