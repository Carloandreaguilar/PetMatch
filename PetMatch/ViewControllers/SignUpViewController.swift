//
//  SignUpViewController.swift
//  PetMatch
//
//  Created by Francesca Valeria Haro Dávila on 2/8/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
  let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
  
  @IBOutlet weak var txtName: UITextField!
  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var txtPassword: UITextField!
  @IBOutlet weak var txtRetypePassword: UITextField!
  
  @IBAction func singInAction(_ sender: Any) {
    
    if txtPassword.text != txtRetypePassword.text {
      let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
      let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      
      alertController.addAction(defaultAction)
      self.present(alertController, animated: true, completion: nil)
    }
    else{
      Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!){ (user, error) in
        self.activityIndicator.startAnimating()
        if error == nil {
            FirebaseData.shared.updateData{
                DispatchQueue.main.async {
                    FirebaseData.shared.loadFirstPicture{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "signupToHome", sender: nil)
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
        self.activityIndicator.stopAnimating()
      }
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    activityIndicator.center = self.view.center
    self.view.addSubview(activityIndicator)
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
