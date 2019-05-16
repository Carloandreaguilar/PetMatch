//
//  ViewController.swift
//  PetMatch
//
//  Created by Francesca Valeria Haro Dávila on 2/7/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class StartViewController: UIViewController, UITextFieldDelegate,GIDSignInDelegate, GIDSignInUIDelegate {
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    @IBAction func logInAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
            if error == nil{
                self.activityIndicator.startAnimating()
                FirebaseData.shared.updateData{
                    DispatchQueue.main.async {
                        FirebaseData.shared.loadFirstPicture{
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
                                self.activityIndicator.stopAnimating()
                            }
                        }
                        
                    }
                }
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func facebookSignIn(_ sender: Any) {
    }
    
    @IBAction func phoneSignIn(_ sender: Any) {
        
    }
    
    @IBAction func googleSignIn(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        self.activityIndicator.startAnimating()
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        // When user is signed in
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
                return
            }
            FirebaseData.shared.updateData{
                DispatchQueue.main.async {
                    FirebaseData.shared.loadFirstPicture{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
                            self.activityIndicator.stopAnimating()
                        }
                    }
                    
                }
            }
        })
        
    }
    // Start Google OAuth2 Authentication
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        
        // Showing OAuth2 authentication window
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
            
        }
    }
    
    // After Google OAuth2 authentication
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        // Close OAuth2 authentication window
        
        dismiss(animated: true) {() -> Void in
            
        }
        
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
}
