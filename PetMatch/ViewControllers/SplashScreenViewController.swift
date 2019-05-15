//
//  SplashScreenViewController.swift
//  PetMatch
//
//  Created by Carlo Andre Aguilar Castrat on 5/14/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase

class SplashScreenViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            FirebaseData.shared.updateData{
                DispatchQueue.main.async {
                    FirebaseData.shared.loadFirstPicture{
                        DispatchQueue.main.async {
                             self.performSegue(withIdentifier: "SplashScreenToHomeScreen", sender: nil)
                        }
                    }
                   
                }
            }
        } else {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
}
