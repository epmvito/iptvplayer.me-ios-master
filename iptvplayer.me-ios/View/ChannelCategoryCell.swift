//
//  MoviesCategoryHeaderTableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 17.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class ChannelCategoryCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var folderImageView: UIImageView!
    @IBOutlet weak var expandAndCollapseImageView: UIImageView!
    
    var title: String? {
        get {
            return titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
        }
    }
    
    func updateCell(isExpanded: Bool) {
        folderImageView.image = isExpanded ? #imageLiteral(resourceName: "folder_open") : #imageLiteral(resourceName: "folder")
        expandAndCollapseImageView.image = isExpanded ? #imageLiteral(resourceName: "close") : #imageLiteral(resourceName: "expand")
    }
}
