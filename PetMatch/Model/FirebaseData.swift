//
//  FirebaseData.swift
//  PetMatch
//
//  Created by Carlo Andre Aguilar Castrat on 5/14/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import Foundation
import Firebase

class FirebaseData{
    static let shared = FirebaseData()
    
    let PetRef = Database.database().reference(withPath: "Pets")
    let storage = Storage.storage()
    var allPets: [Pet] = []
    var allPetImages: [PetImage] = []
    var matchedPets: [Int] = []
    
    
    func updateData(finished: @escaping () -> ()){
        PetRef.observe(.value, with: { snapshot in
            var petsFromFirebase: [Pet] = []
            for child in snapshot.children {
                // 4
                if let snapshot = child as? DataSnapshot,
                    let pet = Pet(snapshot: snapshot) {
                    petsFromFirebase.append(pet)
                }
            }
            self.allPets = petsFromFirebase
            finished()
        })
    }
    
    func loadFirstPicture(finished: @escaping () -> ()){
        if allPets.count >= 1{
            let pet1 = allPets[0]
            let storageRef = self.storage.reference(forURL: pet1.photo)
            storageRef.getData(maxSize: 10 * 1024 *  1024) { (data, error) -> Void in
                if let imgData = data {
                    let pic = UIImage(data: imgData)
                    let petPic = PetImage(key: pet1.key, image: pic ?? UIImage())
                    FirebaseData.shared.allPetImages.append(petPic)
                }
                finished()
            }
        }
    }
}
