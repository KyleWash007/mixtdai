//
//  UIViewController+Alert.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 26/07/25.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String, title: String = "") {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
