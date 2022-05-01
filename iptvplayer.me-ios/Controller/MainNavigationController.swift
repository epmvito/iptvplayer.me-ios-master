//
//  MainNavigationController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 27.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        instantiateInitialVC()
    }
    
    private func instantiateInitialVC() {
        if isProviderMode(), let storyboard = storyboard {
            let userDefaults = UserDefaults.standard
            if let _ = userDefaults.value(forKey: "set-cookie"), let _ = userDefaults.value(forKey: "login"), let _ = userDefaults.value(forKey: "pass") {
                let televisionVC = storyboard.instantiateViewController(identifier: "TabBar")
                pushViewController(televisionVC, animated: false)
            } else {
                let signInVC = storyboard.instantiateViewController(identifier: "signInVC")
                pushViewController(signInVC, animated: false)
            }
        }
    }
    
    fileprivate func isProviderMode() -> Bool {
        return UserDefaults.standard.string(forKey: "providerAPI") != nil ? true : false
    }
}
