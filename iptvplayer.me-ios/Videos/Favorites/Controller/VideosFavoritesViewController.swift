//
//  VideosFavoritesViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 23.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class VideosFavoritesViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    private var items: [Entity] = []
    
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("favorites", comment: "")
        
        activityIndicator.stopAnimating()
        activityIndicator.color = .pacificBlue
        loadData()
        setupCollectionView()

    }
    
    
    // MARK: Methods
    
    private func setupCollectionView() {
        
        let cell = UINib(nibName: "VideosCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "VideosCollectionViewCell")
        
    }
    
    // MARK: Actions

}

    // MARK: Extension for UICollectionViewDataSource

extension VideosFavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as! VideosCollectionViewCell
        cell.delegate = self
        
        let item = items[indexPath.item]
        cell.configurateWithEntity(item)
        
        return cell
    }
}

    // MARK: Extension for VideosCollectionViewCellDelegate

extension VideosFavoritesViewController: VideosCollectionViewCellDelegate {
    
    func favoriteButtonTapped(_ cell: VideosCollectionViewCell, isFavorite: Bool) {
        if let indexPath = collectionView.indexPath(for: cell), let videoCollectionCellModel = items[indexPath.item] as? VideoCollectionCellModel {
            if !isFavorite {
                deleteFavorite(withID: videoCollectionCellModel.id)
            }
            items.remove(at: indexPath.item)
            self.collectionView.reloadData()
        }
    }
}


    // MARK: Extension for UICollectionViewFlowLayout delegate

extension VideosFavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3 * 10.0) / 3
        let wordsCount = countWordsForVideo(items: items)[indexPath.item]
        if wordsCount > 1 {
            return CGSize(width: width, height:(width * 1.3 < ((width * 1.8) + 7 * CGFloat(wordsCount))) ? ((width * 1.8) + 7 * CGFloat(wordsCount)) : width * 1.3)
        } else {
            return CGSize(width: width, height:(width * 1.3 < (width * 1.8)) ? (width * 1.8) : width * 1.3)
        }
    }
}


    // MARK: Extension for data loading

extension VideosFavoritesViewController {
    
    func loadData() {
        items.removeAll()
        self.activityIndicator.startAnimating()
        let service = FavoriteListServiceImpl()
        service.getFavoritesList() { [weak self] (response, error) in
            if let `self` = self {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.showAlertWithTitle(error.errorDescription)
                } else {
                    if let rowVideos = response?.rows {
                        let videos = rowVideos.map({VideoCollectionCellModel(rowVideo: $0)})
                        for video in videos {
                            video.isFavorite = true
                        }
                        self.items = videos
                    }
                    self.collectionView.reloadData()
                }
            }
        }
        self.collectionView.reloadData()
    }
    
    func deleteFavorite (withID id: String) {
           let service = FavoriteListServiceImpl()
           //        self.activityIndicator.startAnimating()
           service.deleteFavorite(withID: id) { (response, error) in
           //            self.activityIndicator.stopAnimating()
           if let error = error {
                   self.showAlertWithTitle(error.errorDescription)
           } else {
               }
           }
       }
}
