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
    private let chatService = ChatGPTService()
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func stepAction1(_ sender: Any) {
        
        let vc = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MetaSelectionViewController") as! MetaSelectionViewController
        self.tappedmeta = 1
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func stepAction2(_ sender: Any) {
        
        if self.metadata1 == nil {
            self.showAlert(message: "Please upload first mixture data")
            return
        }
        let vc = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MetaSelectionViewController") as! MetaSelectionViewController
        self.tappedmeta = 2
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func stepAction3(_ sender: Any) {
        if self.metadata1 == nil {
            self.showAlert(message: "Please upload first mixture data")
            return
        }
        if self.metadata2 == nil {
            self.showAlert(message: "Please upload second mixture data")
            return
        }
        self.getMixAIResponse()
        
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
extension AddViewController {
    func getMixAIResponse() {
        
        let ingredient1 = "\(metadata1?.title ?? "") \(metadata1?.description ?? "")"
        let ingredient2 = "\(metadata2?.title ?? "") \(metadata2?.description ?? "")"
        HUDManager.showHUD()
        self.chatService.generateMixAIResponse(ingredient1: ingredient1, ingredient2: ingredient2) { result in
            
            switch result {
            case .success(let mix):
                print("Experience: \(mix.experience)")
                print("Science: \(mix.science)")
                print("Similar To: \(mix.similarTo)")
                print("Image Prompt: \(mix.generatedImagePrompt)")
                print("Suggested Name: \(mix.suggestedName)")
                print("Improvement Tip: \(mix.improvementTip)")
                self.chatService.generateImageURL(from: "genrate colorfull image of \(mix.suggestedName) of \(self.metadata1?.title ?? "") and \(self.metadata2?.title ?? "")") { imageResult in
                    HUDManager.hideHUD()

                             switch imageResult {
                             case .success(let imageURL):
                                 DispatchQueue.main.async {
                                     self.showDetails(mix: mix, image: imageURL)
                                 }
                             case .failure(let error):
                                 print("Image generation failed: \(error)")
                                 DispatchQueue.main.async {
                                     self.showDetails(mix: mix, image: nil) // fallback
                                 }
                             }
                         }

            case .failure(let error):
                HUDManager.hideHUD()

                print("Error: \(error)")
            }
        }
    }
    func showDetails(mix:MixAIResponse,image:URL?) {
        DispatchQueue.main.async {
            let mixVC = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddMixDataDetailsVC") as! AddMixDataDetailsVC
            mixVC.mix = mix
            mixVC.image = image
            print(image?.absoluteString)
            self.navigationController?.pushViewController(mixVC, animated: true)
        }
    }
}
