//
//  DownloadCollectionViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 03.05.2022.
//  Copyright © 2022 Никита. All rights reserved.
//


import UIKit
import Kingfisher

protocol DownloadCollectionViewCellDelegate: class {
    func favoriteButtonTapped (_ cell: DownloadCollectionViewCell, isFavorite: Bool)
}

class DownloadCollectionViewCell: UICollectionViewCell {
    
 
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!

    
   
    
    weak var delegate: VideosCollectionViewCellDelegate?

    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGroundView.layer.cornerRadius = 5
        imageView.layer.cornerRadius = 5
    }
    

    
    func configurateWithEntity(_ entity: Entity) {
        let video = entity as! VideoCollectionCellModel
        
        if let imageURL = URL(string: video.image) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageURL)
        } else {
            imageView.image = UIImage(named: "video")
        }
        nameLabel.text = video.name
    }
    
}
