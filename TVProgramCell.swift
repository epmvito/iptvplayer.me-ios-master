//
//  TVProgramCell.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 25.09.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class TVProgramCell: UITableViewCell {

    @IBOutlet weak var programTitleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    var programTitle: String? {
        get {
            return programTitleLabel?.text
        }
        set {
            programTitleLabel.text = newValue
        }
    }
    
    var startTime: String? {
        get {
            return startTimeLabel?.text
        }
        set {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            let startTime = Date(timeIntervalSince1970: TimeInterval(newValue!)!)
            let startTimeString = dateFormatter.string(from: startTime)
            startTimeLabel?.text = startTimeString
        }
    }
    
    var endTime: String? {
        get {
            return endTimeLabel?.text
        }
        set {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            let endTime = Date(timeIntervalSince1970: TimeInterval(newValue!)!)
            let endTimeString = dateFormatter.string(from: endTime)
            endTimeLabel?.text = endTimeString
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
