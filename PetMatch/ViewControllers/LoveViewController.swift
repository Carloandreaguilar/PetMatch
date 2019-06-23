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
    
    var selectedIndex = 0
    
    @IBOutlet weak var loversTableView: UITableView!
    
    let loversTableViewCellIdentifier = "LoversCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loversTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ChatFrameViewController {
            destinationViewController.name = FirebaseData.shared.allPets[FirebaseData.shared.matchedPets[self.selectedIndex]].name
            destinationViewController.photo = FirebaseData.shared.allPetImages[FirebaseData.shared.matchedPets[self.selectedIndex]].image ?? UIImage()
        }
    }
}


extension LoveViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseData.shared.matchedPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.loversTableViewCellIdentifier, for: indexPath) as? LoversTableViewCell else {
            return UITableViewCell()
        }
        cell.loverImage.image = FirebaseData.shared.allPetImages[FirebaseData.shared.matchedPets[indexPath.row]].image
        cell.loverName.text = FirebaseData.shared.allPets[FirebaseData.shared.matchedPets[indexPath.row]].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
    }
}
