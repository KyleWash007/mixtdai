//
//  AddViewController.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 25/07/25.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var firstTextFiled: UITextField!
    @IBOutlet weak var secondTextFiled: UITextField!
    var seachIndex = 1
    var tappedmeta: Int = 1
    var loaderAnimationView:LoaderAnimationView?
    private let chatService = ChatGPTService()
    
        @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        self.btnNext.applyGradient(colors: [
              UIColor.purple,UIColor.blue
          ])
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if let txt = self.firstTextFiled.text,  txt.isEmpty {
            self.showAlert(message: "Please add first mixture")
            return
        }
        if let txt = self.secondTextFiled.text,  txt.isEmpty {
            self.showAlert(message: "Please add second mixture")
            return
        }
        if  self.loaderAnimationView ==  nil {
            self.loaderAnimationView = LoaderAnimationView(frame: view.bounds)
        }
        view.addSubview( self.loaderAnimationView!)
        self.loaderAnimationView?.startAnimation()
        self.getMixAIResponse()

    }
    @IBAction func firstMixtureSeach(_ sender: Any) {
        
        let vc = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchDataVC") as! SearchDataVC
        vc.delegate = self
        seachIndex = 1
        vc.seachTxt = self.firstTextFiled.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func secondMixtureSeach(_ sender: Any) {
        let vc = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchDataVC") as! SearchDataVC
        vc.delegate = self
        vc.seachTxt = self.secondTextFiled.text ?? ""
        seachIndex = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddViewController {
    func getMixAIResponse() {
        self.firstTextFiled.resignFirstResponder()
        self.secondTextFiled.resignFirstResponder()

        let ingredient1 = self.firstTextFiled.text ?? ""
        let ingredient2 = self.secondTextFiled.text ?? ""
        self.chatService.generateMixAIResponse(ingredient1: ingredient1, ingredient2: ingredient2) { result in
            switch result {
            case .success(let mix):
                print("Experience: \(mix.experience)")
                print("Science: \(mix.science)")
                print("Similar To: \(mix.similarTo)")
                print("recommendedRatio : \(mix.recommendedRatio)")
                print("Suggested Name: \(mix.suggestedName)")
                print("Improvement Tip: \(mix.improvementTip)")
                DispatchQueue.main.async {
                    self.showDetails(mix: mix,imageul: nil,image: nil)

                    //self.createAiImage(mix: mix)
                }

//                DispatchQueue.main.async {
//                    
//                    let alert = UIAlertController(title: "Choose Option",
//                                                  message: "Do you want to generate a new image using AI, or just combine the two images directly?",
//                                                  preferredStyle: .alert)
//                    
//                    let aiGenerateAction = UIAlertAction(title: "AI Generate", style: .default) { _ in
//                        // Handle AI image generation here
//                        print("AI Generate option selected")
//                        // Example: callAPIToGenerateAIImage(from: image1, and: image2)
//                        self.createAiImage(mix: mix)
//                    }
//                    
//                    let combineImagesAction = UIAlertAction(title: "Combine Images", style: .default) { _ in
//                        // Handle local image merge here
//                        let combined = HUDManager.mergeImagesWithSmoothBlend(image1: self.metadata1!.image!, image2: self.metadata2!.image!)
//                        
//                        self.showDetails(mix: mix,imageul: nil,image: combined)
//                    }
//                    
//                    
//                    alert.addAction(aiGenerateAction)
//                    alert.addAction(combineImagesAction)
//                    
//                    self.present(alert, animated: true, completion: nil)
//                }

            case .failure(let error):
                HUDManager.hideHUD()

                print("Error: \(error)")
            }
        }
    }
    func createAiImage(mix:MixAIResponse) {
        self.chatService.generateImageURL(from: "Create a combined circular colorfull logo of \(self.firstTextFiled.text ?? "") and \(self.secondTextFiled.text ?? "")") { imageResult in
                     switch imageResult {
                     case .success(let imageURL):
                         DispatchQueue.main.async {
                             self.showDetails(mix: mix, imageul: imageURL, image: nil)
                         }
                     case .failure(let error):
                         print("Image generation failed: \(error)")
                         DispatchQueue.main.async {
                             self.showDetails(mix: mix,imageul: nil,image: nil)
                         }
                     }
                 }
    }
    func showDetails(mix:MixAIResponse,imageul:URL?,image:UIImage?) {
        
        DispatchQueue.main.async {
            HUDManager.hideHUD()
            self.loaderAnimationView?.removeFromSuperview()
            
            let mixVC = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddMixDataDetailsVC") as! AddMixDataDetailsVC
            mixVC.image = imageul
            mix.leftIngredient = self.firstTextFiled.text ?? ""
            mix.rightIngredient = self.secondTextFiled.text ?? ""
            mixVC.mix = mix

            if let image {
                mixVC.imageViewShow = image
                mixVC.imageData = image.pngData()

            }
            print(imageul?.absoluteString)
            self.navigationController?.pushViewController(mixVC, animated: true)
        }
    }
}
extension AddViewController : UITextFieldDelegate {
    
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
        if newString.length >= 140 {
            return false
        }
        return true
    }
    
}
extension AddViewController : SearchDataDelegate {
    func didSelectBeer(_ beer: Beer) {
        print("🍺 Selected Beer: \(beer.name ?? "Unknown") from \(beer.brewery ?? "")")

        if self.seachIndex == 1 {
            self.firstTextFiled.text = beer.name
        }else {
            self.secondTextFiled.text = beer.name

        }
    }
    
    
}
