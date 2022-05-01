//
//  IPTVPlayerMeViewController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 07.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    

}
