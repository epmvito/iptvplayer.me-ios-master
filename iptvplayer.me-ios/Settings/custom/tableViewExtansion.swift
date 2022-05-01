//
//  tableViewExtansion.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 17.04.2022.
//  Copyright © 2022 Никита. All rights reserved.
//

import Foundation
import UIKit

class table: UITableViewCell{
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 4
            super.frame = frame
        }
    }
}
