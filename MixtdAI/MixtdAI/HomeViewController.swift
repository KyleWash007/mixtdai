//
//  HomeViewController.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 25/07/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func callAddData(_ sender: Any) {
        let vc = UIStoryboard(name: "AddStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as! AddViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }

}
