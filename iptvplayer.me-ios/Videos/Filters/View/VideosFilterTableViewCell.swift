//
//  VideosFilterTableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

protocol VideosFilterTableViewCellDelegate: class {
    func cellTapped(_ cell: VideosFilterTableViewCell)
}

class VideosFilterTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedLabel: UILabel!
    
    // MARK: Properties
    
    weak var delegate: VideosFilterTableViewCellDelegate?
    
    // MARK: Lyfecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
        
    }
    
    // MARK: Methods

    func configureWithEntity(_ entity: Entity) {
        let videosFilterTableCellmodel = entity as! VideosFilterTableCellModel
        nameLabel.text = videosFilterTableCellmodel.filterName
        selectedLabel.text = videosFilterTableCellmodel.selected
    }
    
    // MARK: Actions
    
    @objc func cellTapped() {
        delegate?.cellTapped(self)
    }
    
}
