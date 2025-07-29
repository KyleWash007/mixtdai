//
//  HomeViewController.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 25/07/25.
//

import UIKit
import IQKeyboardManagerSwift

class HomeViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mixtdlogo")) // Replace with your image name
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let splash = SplashAnimationView(frame: self.view.bounds)
        self.view.addSubview(splash)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func callAddData(_ sender: Any) {
        let vc = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
