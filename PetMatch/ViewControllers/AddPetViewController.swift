//
//  AddPetViewController.swift
//  PetMatch
//
//  Created by Carlo Aguilar on 2/10/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import Firebase

class AddPetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    
    let genders = ["Male","Female"]
    let types = ["Cat","Dog", "Hamster"]
    var image = UIImage()
    
    var imagePicker = UIImagePickerController()
    var pet = Pet(key:  "" ,type: "Cat", name: "", birthdate: "", about: "", gender: "Male", owner: "", photo: "" )
    var petGender = ""
    var petType = ""
    let ref = Database.database().reference(withPath: "Pets")
    let usersRef = Database.database().reference(withPath: "Users")
    let storage = Storage.storage()
    let dateFormatter = DateFormatter()
    
    
    
    @IBAction func photoFromLibrary(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.petType = types[0]
        self.petGender = genders[0]
        self.imagePicker.delegate = self
        if pet.key != "" {
            self.addImageButton.setImage(self.image, for: UIControl.State.normal)
            self.nameText.text = pet.name
            self.descriptionText.text = pet.about
            self.birthdatePicker.date = dateFormatter.date(from: pet.birthdate) ?? Date()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nameText.becomeFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == typePicker {
            return 1
        } else if pickerView == genderPicker {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typePicker {
            return self.types.count
        } else if pickerView == genderPicker {
            return self.genders.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typePicker {
            return types[row]
        } else if pickerView == genderPicker {
            return genders[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case typePicker:
            pet.type = types[row]
        case genderPicker:
            pet.gender = genders[row]
        default:
            return
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if pet.key == "" {
            self.pet.name = self.nameText.text ?? ""
            dateFormatter.dateFormat = "MM-dd-yyyy"
            self.pet.birthdate = dateFormatter.string(from: birthdatePicker.date)
            self.pet.about = self.descriptionText.text ?? ""
            self.pet.owner = Auth.auth().currentUser!.uid
            
            
            let data = addImageButton.currentImage?.jpegData(compressionQuality: 1.0) ?? Data()
            let storageRef = storage.reference()
            // Create a reference to the file you want to upload
            let uniqueID = UUID().uuidString
            
            let imageRef = storageRef.child("images/" + self.pet.name + uniqueID + ".jpg")
            
            let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                // You can also access to download URL after upload.
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    self.pet.photo = downloadURL.absoluteString
                    //let pet = Pet(type: type, name: name, birthdate: birthdate, about: about, gender: gender, owner: owner, photo: photo)
                    let petRef = self.ref.childByAutoId()
                    petRef.setValue(self.pet.toAnyObject())
                    
                }
            }
            
        } else {
            self.pet.name = self.nameText.text ?? ""
            dateFormatter.dateFormat = "MM-dd-yyyy"
            self.pet.birthdate = dateFormatter.string(from: birthdatePicker.date)
            self.pet.about = self.descriptionText.text ?? ""
            self.pet.ref?.updateChildValues(["Name": self.pet.name])
            
        }
         self.navigationController?.popViewController(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] {
            self.addImageButton.setImage(img as? UIImage, for: UIControl.State.normal)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}


