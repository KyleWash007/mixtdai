//
//  HUDManager.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 27/07/25.
//


import SVProgressHUD

class HUDManager {

    // Show the HUD
    static func showHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultMaskType(.clear)  // Set clear mask type to show the HUD without blocking interaction
            SVProgressHUD.show()
        }
    }

    // Hide the HUD
    static func hideHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
