//
//  PrimaryButton.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 03.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
    
    // MARK: Inspectable
    
    @IBInspectable var color: UIColor? {
        didSet {
            self.backgroundColor = color
        }
    }

    // MARK: Lifecycle
    
    override func awakeFromNib() {
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
        
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
}
