//
//  VideosFilterTypeTableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

protocol VideosFilterSortingTableViewCellDelegate: class {
    func selectButton(_ cell: VideosFilterSortingTableViewCell, isLastSelected: Bool)
}

class VideosFilterSortingTableViewCell: UITableViewCell {

    
    // MARK: Outlets
    
    @IBOutlet weak var lastButton: UIButton!
    @IBOutlet weak var bestButton: UIButton!
    
    // MARK: Propeties

    weak var delegate: VideosFilterSortingTableViewCellDelegate?
    
    // MARK: Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lastButton.tintColor = UIColor.pacificBlue
        bestButton.tintColor = UIColor.pacificBlue
        
    }
    
    // MARK: Methods

    
    func setOptionSelected(_ isLastSelected: Bool) {
        if isLastSelected {
            self.lastButton.isSelected = true
            self.bestButton.isSelected = false
        } else {
            self.lastButton.isSelected = false
            self.bestButton.isSelected = true
        }
    }
    
    func configureWithEntity(_ entity: Entity) {
        
        let videosFilterDetailsTableCellModel = entity as! VideosFilterTableCellModel
        if videosFilterDetailsTableCellModel.selected == "last" {
            setOptionSelected(true)
        } else {
            setOptionSelected(false)
        }
        
    }
    // MARK: Actions
    
    @IBAction func lastButtonSelected(_ sender: UIButton) {
        setOptionSelected(true)
        delegate?.selectButton(self, isLastSelected: lastButton.isSelected)
    }
    
    @IBAction func bestButtonSelected(_ sender: UIButton) {
        setOptionSelected(false)
        delegate?.selectButton(self, isLastSelected: lastButton.isSelected)
    }
}
