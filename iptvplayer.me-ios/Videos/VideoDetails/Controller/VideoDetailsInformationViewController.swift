//
//  VideoDetailsInformationViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 23.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit
import Kingfisher

class VideoDetailsInformationViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameAndYearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var countryAndTimeLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var kinopoiskLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var producersLabel: UILabel!
    @IBOutlet weak var studioLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    public var id: String = ""
    
    // MARK: Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.stopAnimating()
        activityIndicator.color = .pacificBlue
        
        title = NSLocalizedString("information", comment: "")
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: Methods
    
}

    // MARK: Extensions for data loading

extension VideoDetailsInformationViewController {
    
    func loadData () {
        self.activityIndicator.startAnimating()
        let service = VideoDetailsServiceImpl()
        service.getVideoDetails(withID: id) { [weak self] (respoonse, error) in
            if let `self` = self {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.showAlertWithTitle(error.errorDescription)
                } else {
                    if let videoDetail = respoonse?.film {
                        videoFileList = videoDetail.videos!
                        if let imageURL = URL(string: videoDetail.posterUrl!) {
                            self.imageView.kf.indicatorType = .activity
                            self.imageView.kf.setImage(with: imageURL)
                        } else {
                            self.imageView.image = UIImage(named: "video")
                        }
                        self.nameAndYearLabel.text = videoDetail.nameOrig! + " (\(videoDetail.year!))"
                        self.genresLabel.text = videoDetail.genre
                        if let doubleMin = videoDetail.lenght {
                            let doubleSec = doubleMin * 60
                            let intSec = Int(round(doubleSec))
                            let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds: intSec)
                            self.countryAndTimeLabel.text = videoDetail.country! + ", \(h):\(m):\(s)"

                        } else {
                            self.countryAndTimeLabel.text = videoDetail.country!
                            }
                        if let rate = Double(videoDetail.rateIMDB!) {
                            if rate >= 7.0 {
                                self.imdbLabel.textColor = .brightGreen
                            } else if rate <= 5 {
                                self.imdbLabel.textColor = .brightRed
                            } else {
                                self.imdbLabel.textColor = .warmGrey
                            }
                        }
                        self.imdbLabel.text = videoDetail.rateIMDB
                        if let rate = Double(videoDetail.rateKinopoisk!) {
                            if rate >= 7.0 {
                                self.kinopoiskLabel.textColor = .brightGreen
                            } else if rate <= 5 {
                                self.kinopoiskLabel.textColor = .brightRed
                            } else {
                                self.kinopoiskLabel.textColor = .warmGrey
                            }
                        }
                        self.kinopoiskLabel.text = videoDetail.rateKinopoisk
                        self.informationLabel.text = videoDetail.description
                        self.actorsLabel.text = videoDetail.actors
                        self.producersLabel.text = videoDetail.director
                        self.studioLabel.text = videoDetail.studio
                    }
                }
            }
        }
    }
}
