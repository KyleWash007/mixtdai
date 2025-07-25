//
//  UIDevice+Extention.swift
//  Leaderly
//
//  Created by Aravind Kumar on 26/09/23.
//

import Foundation
import UIKit

extension UIApplication {
  
  static var appVersion: String {
    if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
      return "\(appVersion)"
    } else {
      return "0.0"
    }
  }
  
  static var build: String {
    if let buildVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) {
      return "\(buildVersion)"
    } else {
      return ""
    }
  }
  static var appIdentifier: String {
    if let buildVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) {
      return "\(buildVersion)"
    } else {
      return ""
    }
  }
  static var appName: String {
    if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") {
      return "\(appVersion)"
    } else {
      return ""
    }
  }
  
  static var versionBuild: String {
    let version = UIApplication.appVersion
      let versionAndBuild = " Version - \(version)"
        return versionAndBuild
  }
  
}
