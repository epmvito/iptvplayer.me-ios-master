//
//  VideosCollectionViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 12.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit
import Kingfisher

protocol VideosCollectionViewCellDelegate: class {
    func favoriteButtonTapped (_ cell: VideosCollectionViewCell, isFavorite: Bool)
}

class VideosCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: Properties
    
    weak var delegate: VideosCollectionViewCellDelegate?
    
    var isFavorite: Bool = false {
        didSet {
            updateFavoriteButtonStatus()
        }
    }
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGroundView.layer.cornerRadius = 5
        imageView.layer.cornerRadius = 5
    }
    
    // MARK: Methods
    
    func configurateWithEntity(_ entity: Entity) {
        let video = entity as! VideoCollectionCellModel
        
        if let imageURL = URL(string: video.image) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageURL)
        } else {
            imageView.image = UIImage(named: "video")
        }
        nameLabel.text = video.name
        isFavorite = video.isFavorite
    }
    
    func updateFavoriteButtonStatus() {
        favoriteButton?.tintColor = isFavorite ? UIColor.pacificBlue : UIColor.white
    }
    
    // MARK: Actions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        isFavorite = !isFavorite
        delegate?.favoriteButtonTapped(self, isFavorite: isFavorite)
    }
}
