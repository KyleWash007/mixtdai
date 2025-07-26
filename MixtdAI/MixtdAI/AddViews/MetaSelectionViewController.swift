//
//  MetaSelectionViewController.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 26/07/25.
//

import UIKit

class MetaSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
