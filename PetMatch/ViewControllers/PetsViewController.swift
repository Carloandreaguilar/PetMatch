//
//  PetsViewController.swift
//  PetMatch
//
//  Created by Carlo Aguilar on 2/9/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase

class PetsViewController: UIViewController {
    
    @IBOutlet weak var petsTableView: UITableView!
    let storage = Storage.storage()
    var myPets: [Pet] = []
    var user: User!
    let usersRef = Database.database().reference(withPath: "Users")
    let petRef = Database.database().reference(withPath: "Pets")
    let dateFormatter = DateFormatter()
    
  @IBAction func addButton(_ sender: UIButton) {
    
    Analytics.logEvent("addNewPetButton", parameters: [:])
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPet" {
            if let destinationVC = segue.destination as? AddPetViewController {
                print("todoo esta bien")
                if let indexPathRow = sender as? Int {
                let existingPet = self.myPets[indexPathRow]
                    destinationVC.pet.key = existingPet.key
                    destinationVC.pet.birthdate = existingPet.birthdate
                    destinationVC.pet.about = existingPet.about
                    destinationVC.pet.name = existingPet.name
                    destinationVC.pet.photo = existingPet.photo
                    destinationVC.pet.owner = existingPet.owner
                    destinationVC.pet.ref = existingPet.ref
                    let storageRef = storage.reference(forURL: existingPet.photo)
                    storageRef.getData(maxSize: 5 * 1024 *  1024) { (data, error) -> Void in
                        if let imgData = data {
                            destinationVC.image = UIImage(data: imgData) ?? UIImage()
                        }
                    }
                    
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petRef.queryOrdered(byChild: "Owner").queryEqual(toValue: Auth.auth().currentUser!.uid).observe(.value, with: { snapshot in
            var petsFromFirebase: [Pet] = []
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    let pet = Pet(snapshot: snapshot) {
                    petsFromFirebase.append(pet)
                }
            }
            self.myPets = petsFromFirebase
            self.petsTableView.reloadData()
        })
    }
    
}
extension PetsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pet = myPets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pet.name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        
        let pet = myPets[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.myPets.remove(at: (self.myPets.firstIndex(of: pet))!)
            pet.ref?.removeValue()
            self.petsTableView.reloadData()
        }
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            
            self.performSegue(withIdentifier: "editPet", sender: indexPath.row)
            self.petsTableView.reloadData()
            
        }
        
        editAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return [deleteAction, editAction]
        
    }
    
}
