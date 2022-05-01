//
//  VideosFilterDetailsTableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

protocol VideosFilterDetailsTableViewCellDelegate: class {
    func checkBoxHasBeenSelected(_ cell: VideosFilterDetailsTableViewCell, name: String, isSelected: Bool)
}

class VideosFilterDetailsTableViewCell: UITableViewCell {
    
    // MARK: OUTLETS

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    // MARK: Properties
    
    weak var delegate: VideosFilterDetailsTableViewCellDelegate?
    
    // MARK: Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkBoxButton.tintColor = UIColor.pacificBlue
        
    }
    
    // MARK: Actions
    
    @IBAction func checkBoxButtonSelected(_ sender: UIButton) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
        delegate?.checkBoxHasBeenSelected(self, name: nameLabel.text!, isSelected: checkBoxButton.isSelected)
    }
    
    func configureWithEntity(_ entity: Entity) {
        let videosFilterDetailsTableCellModel = entity as! VideosFilterDetailsTableCellModel
        
        nameLabel.text = videosFilterDetailsTableCellModel.name
        checkBoxButton.isSelected = videosFilterDetailsTableCellModel.isSelected!
        
    }
    
}
