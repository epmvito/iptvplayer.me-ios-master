//
//  MovieTableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 18.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var channelLogoImageView: UIImageView!
    
//    func setupCell(channelName: String, program: String, channelLogo: UIImage) {
//        channelNameLabel.text = channelName
//        programNameLabel.text = program
//        channelLogoImageView.image = channelLogo
//        channelLogoImageView.layer.cornerRadius = channelLogoImageView.frame.height / 2
//    }
    
    func setupCell1(channelList:Channel){
        
        channelNameLabel.text = channelList.name
        programNameLabel.text = channelList.epg_progname
        if let iconURL = URL(string: channelList.icon_url!) {
            channelLogoImageView.image = nil
                channelLogoImageView.kf.setImage(with: iconURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { result in
                switch result {
                    case .success(let value):
                                print("Image: \(value.image). Got from: \(value.cacheType)")
                    case .failure(let error):
                                print("Error: \(error)")
                    }
                })
        }
        channelLogoImageView.layer.cornerRadius = channelLogoImageView.frame.height / 2
        
        
    }
    
}
