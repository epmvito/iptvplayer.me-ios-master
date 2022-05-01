//
//  ProviderHintCell.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 13.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class ProviderHintCell: UITableViewCell {
    @IBOutlet weak var providerHintTextLabel: UILabel!
    
    var providerHintText: String? {
        get {
            return providerHintTextLabel?.text
        }
        set {
            providerHintTextLabel?.text = newValue
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
