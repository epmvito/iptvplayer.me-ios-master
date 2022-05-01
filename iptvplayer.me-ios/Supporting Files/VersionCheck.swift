//
//  VersionCheck.swift
//  iptvplayer.me-ios
//
//  Created by deep on 08/04/22.
//  Copyright © 2022 Никита. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class VersionCheck: UIViewController {
  
  public static let shared = VersionCheck()
    private var window:UIWindow!
  func isUpdateAvailable(callback: @escaping (Bool)->Void) {
  //  let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
 // http://api.iptvplayer.me/appversions/
 // https://itunes.apple.com/lookup?bundleId=\(bundleId)
      
    func rootViewController() -> UIViewController {
          // cheating, I know

          return UIApplication.shared.keyWindow!.rootViewController!
      }
      
    //  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    AF.request("http://api.iptvplayer.me/appversions/").responseJSON { response in
        
        
        if response.error == nil {
            
            let value:NSDictionary = response.value as! NSDictionary
            let getVersion = value.value(forKey: "ios-mobile-ver") as! String
            let getversionURl = value.value(forKey: "ios-mobile-link") as! String
            
            
            let version1 = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            let version2 = getVersion
    
            let result = version1?.compare(version2, options: .numeric)
            switch result {
            case .orderedSame : print("versions are equal")
            case .orderedAscending :
                
                DispatchQueue.main.async {
                    
                    // create the alert
                    let alert = UIAlertController(title: NSLocalizedString("notice", comment: ""), message: NSLocalizedString("latestVersion", comment: ""), preferredStyle: UIAlertController.Style.alert)

                            // add the actions (buttons)
                           
                           alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: UIAlertAction.Style.default, handler: { UIAlertAction in
                        print("okay")
                            if let url = URL(string: getversionURl) {
                                           UIApplication.shared.open(url)
                                       }
                    }))
                            alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: UIAlertAction.Style.cancel, handler: nil))
                            // show the alert
                    rootViewController().present(alert, animated: true, completion: nil)
                }
                
                print("download new")
                print("version1 is less than version2")
            case .orderedDescending : print("version1 is greater than version2")
            case .none:
                break
            }
            
        }
    }
      callback(false)
  }
  
}
