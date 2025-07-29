//
//  MetaSelectionViewController.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 26/07/25.
//

import UIKit
struct MetaData{
    var title:String?
    var description:String?
    var image:UIImage?
}
protocol MetaSelectionDelegate:AnyObject{
    func metaDataSelected(metaData:MetaData)
}

class MetaSelectionViewController: UIViewController {
  
    weak var delegate:MetaSelectionDelegate?
    
    @IBOutlet weak var lblTitle: UILabel!
    var pickedImage:UIImage?
    @IBOutlet weak var descptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addUiComponents()
    }
    func addUiComponents(){
        self.titleTextField.delegate = self
        self.descptionTextView.delegate = self
        
        imageView.isUserInteractionEnabled = true
               // Create gesture recognizer
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
               // Add the gesture to the image view
        imageView.addGestureRecognizer(tapGesture1)
        
    }
    @objc func imageTapped() {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Mixtd AI", message: "Choose any one option for upload image", preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.camPick()
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Photos", style: .default) { action -> Void in
            self.galleryPick()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
       

        self.present(actionSheetController, animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func imageSection(){
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Mixtd AI", message: "Choose any one option for upload image", preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.camPick()
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Photos", style: .default) { action -> Void in
            self.galleryPick()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
       

        self.present(actionSheetController, animated: true)
        
    }
    @IBAction func beNextAction(_ sender: Any) {
        if let title = self.titleTextField.text, title.isEmpty {
            self.showAlert(message: "Please enter title")
            return
        }
        if let title = self.descptionTextView.text, title.isEmpty {
            self.showAlert(message: "Please enter description")
            return
        }
        if pickedImage == nil {
            self.showAlert(message: "Please add image")
            return
        }
        
        let meta = MetaData(title: self.titleTextField.text,description: self.descptionTextView.text,image: self.pickedImage)
        self.delegate?.metaDataSelected(metaData: meta)
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension MetaSelectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    func galleryPick() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
            imagePicker.navigationBar.tintColor = .black
            imagePicker.navigationBar.barStyle = .black
            
            self.present(imagePicker, animated: true, completion:nil)
            imagePicker.delegate = self
        } else {
            self.showAlert(message: "You denied permissions to access your photos. You'll need to allow permissions to choose photos to post.", title: "Permission Denied")

        }
        
    }
    func camPick() {
         if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
             let imagePicker = UIImagePickerController()
             imagePicker.allowsEditing = false
             imagePicker.sourceType = .camera
             
             imagePicker.navigationBar.tintColor = .black
             imagePicker.navigationBar.barStyle = .black
             
             self.present(imagePicker, animated: true, completion:nil)
             imagePicker.delegate = self
         } else {
             self.showAlert(message: "You denied permissions to access your camera. You'll need to allow permissions to choose photos to post.", title: "Permission Denied")
         }
         
     }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageUploaded = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
         
            pickedImage = imageUploaded
            self.imageView.image = imageUploaded

        }else if let imageUploaded = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
         
            pickedImage = imageUploaded
            self.imageView.image = imageUploaded
        }

        dismiss(animated: true, completion: nil)
    }
}
extension MetaSelectionViewController : UITextFieldDelegate,UITextViewDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length == 1 && newString == " " {
            return false
        }
        if newString.length >= 75 {
            return false
        }
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          let currentText = textView.text ?? ""
          guard let stringRange = Range(range, in: currentText) else { return false }
          let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
          return updatedText.count <= 5000
      }
}
