//
//  AddViewController.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 25/07/25.
//

import UIKit

class AddViewController: UIViewController {
    
    var metadata1: MetaData?
    var metadata2: MetaData?
    var tappedmeta: Int = 1
    
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
        
        let vc = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MetaSelectionViewController") as! MetaSelectionViewController
        self.tappedmeta = 1
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func imageTapped2() {
        if self.metadata1 == nil {
            self.showAlert(message: "Please upload first mixture data")
            return
        }
        let vc = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MetaSelectionViewController") as! MetaSelectionViewController
        self.tappedmeta = 2
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddViewController : MetaSelectionDelegate {
    func metaDataSelected(metaData: MetaData) {
        if tappedmeta == 1 {
            self.metadata1 = metaData
            self.image1.image = metaData.image
        }
        else if tappedmeta == 2 {
            self.metadata2 = metaData
            self.image2.image = metaData.image
        }
    }
    
}
