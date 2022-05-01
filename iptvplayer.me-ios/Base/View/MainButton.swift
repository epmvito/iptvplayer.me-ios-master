//
//  IPTVPlayerMeButton.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 07.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class MainButton: UIButton {

    override func awakeFromNib() {
        backgroundColor = UIColor.pacificBlue
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = self.frame.height / 2
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
    
}
