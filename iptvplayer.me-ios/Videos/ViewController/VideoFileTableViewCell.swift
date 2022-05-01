//
//  VideoFileTableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by deep on 14/04/22.
//  Copyright © 2022 Никита. All rights reserved.
//

import UIKit



class VideoFileTableViewCell: UITableViewCell {

    @IBOutlet weak var formatName:UILabel!
    @IBOutlet weak var formatNo:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
