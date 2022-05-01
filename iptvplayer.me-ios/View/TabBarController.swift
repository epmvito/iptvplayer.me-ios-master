//
//  TabBarController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 12.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
