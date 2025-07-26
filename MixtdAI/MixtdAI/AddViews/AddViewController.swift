//
//  AddViewController.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 25/07/25.
//

import UIKit

class AddViewController: UIViewController {
    var image1Data: UIImage?
    var image2Data: UIImage?
    var tappedImage: Int = 0
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        image1.isUserInteractionEnabled = true
               
               // Create gesture recognizer
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped1))
               
               // Add the gesture to the image view
        image1.addGestureRecognizer(tapGesture1)
        
        image2.isUserInteractionEnabled = true
               
               // Create gesture recognizer
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2))
               
               // Add the gesture to the image view
        image2.addGestureRecognizer(tapGesture2)
        
    }
    @objc func imageTapped1() {
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Mixtd AI", message: "Choose any one option for upload image", preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.tappedImage = 1
            self.camPick()
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Photos", style: .default) { action -> Void in
            self.tappedImage = 1
            self.galleryPick()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
       

        self.present(actionSheetController, animated: true)
        
    }
    @objc func imageTapped2() {
        
        if self.image1Data == nil {
            self.showAlert(message: "Please upload first image")
            return
        }
        let actionSheetController: UIAlertController = UIAlertController(title: "Mixtd AI", message: "Choose any one option for upload image", preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.tappedImage = 2
            self.camPick()
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Photos", style: .default) { action -> Void in
            self.tappedImage = 2
            self.galleryPick()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
       

        self.present(actionSheetController, animated: true)
        
    }
}
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   func galleryPick() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            
            imagePicker.navigationBar.tintColor = .black
            imagePicker.navigationBar.barStyle = .black
            
            self.present(imagePicker, animated: true, completion:nil)
            imagePicker.delegate = self
        } else {
            showAlert(message: "You denied permissions to access your photos. You'll need to allow permissions to choose photos to post.")

        }
        
    }
    func camPick() {
         if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
             let imagePicker = UIImagePickerController()
             imagePicker.allowsEditing = true
             imagePicker.sourceType = .camera
             
             imagePicker.navigationBar.tintColor = .black
             imagePicker.navigationBar.barStyle = .black
             
             self.present(imagePicker, animated: true, completion:nil)
             imagePicker.delegate = self
         } else {
             showAlert(message: "You denied permissions to access your camera. You'll need to allow permissions to choose photos to post.")
         }
         
     }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageUploaded = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if self.tappedImage == 1 {
                self.image1Data = imageUploaded
            self.image1.image = imageUploaded
            }else {
                self.image2Data = imageUploaded
                self.image2.image = imageUploaded
            }
//            pickedImage = imageUploaded
//            self.img.image = imageUploaded

        }else if let imageUploaded = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if self.tappedImage == 1 {
                self.image1Data = imageUploaded
            self.image1.image = imageUploaded
            }else {
                self.image2Data = imageUploaded
                self.image2.image = imageUploaded
            }
//            pickedImage = imageUploaded
//            self.img.image = imageUploaded
        }

        dismiss(animated: true, completion: nil)
    }
    func showAlert(message:String) {
        let alert = UIAlertController(
            title: "Permission Denied",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
