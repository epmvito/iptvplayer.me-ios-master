//
//  VideosNewViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 12.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

class VideosNewViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Private properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var items: [Entity] = []
    private var indexPage: Int = 1
    private var pageHeight: Int = 20
    var searchString: String = ""
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = NSLocalizedString("video", comment: "")
        
        
        favoritesButton.layer.cornerRadius = favoritesButton.bounds.height/2
        
        navigationItem.searchController = searchController
        activityIndicator.stopAnimating()
        
        definesPresentationContext = true
        setupCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchController()
        getVideoList(WithSearchText: nil)
    }
    
    // MARK: Methods
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("search", comment: "search")
        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true
        let filers = getFilters()
        if filers.count < 1 {
            searchController.searchBar.setImage(UIImage(named: "filter_list"), for: .bookmark, state: .normal)
        } else {
            searchController.searchBar.setImage(UIImage(named: "filterYes_list"), for: .bookmark, state: .normal)
        }
        
        
    }
    
    private func setupCollectionView() {
        
        let cell = UINib(nibName: "VideosCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "VideosCollectionViewCell")
        
    }
    
    // MARK: Actions
    
    @IBAction func favoritesButtonTapped(_ sender: UIButton) {
        let favoriteVC = UIStoryboard(name: "VideosFavorites", bundle: nil).instantiateViewController(identifier: "VideosFavoritesViewController")
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
}

    // MARK: Extension for UICollectionViewDataSource

extension VideosNewViewController: UICollectionViewDataSource {
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

// MARK: Extension for UICollectionViewDelegate


extension VideosNewViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.y/view.bounds.size.height * 10
        
        let intIndex = Int(index) + 6
        if intIndex > pageHeight {
            indexPage += 1
            pageHeight += 20
            if searchString != "" {
                getNextVideoList(WithSearchText: searchString)
            } else {
                getNextVideoList(WithSearchText: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.items[indexPath.item] as! VideoCollectionCellModel
        let videoDetailsVC = UIStoryboard(name: "VideoDetails", bundle: nil).instantiateViewController(identifier: "VideoDetailsMainViewController") as! VideoDetailsMainViewController
        videoDetailsVC.title = item.name
        videoDetailsVC.id = item.id
        videoDetailsVC.isFavorite = item.isFavorite
    
        self.navigationController?.pushViewController(videoDetailsVC, animated: true)
    }
}

    // MARK: Extension for VideosCollectionViewCellDelegate

extension VideosNewViewController: VideosCollectionViewCellDelegate {
    
    func favoriteButtonTapped(_ cell: VideosCollectionViewCell, isFavorite: Bool) {
        if let indexPath = collectionView.indexPath(for: cell), let videoCollectionCellModel = items[indexPath.item] as? VideoCollectionCellModel {
            if isFavorite {
                addFavorite(withID: videoCollectionCellModel.id)
            } else {
                deleteFavorite(withID: videoCollectionCellModel.id)
            }
            videoCollectionCellModel.isFavorite = isFavorite
            items[indexPath.item] = videoCollectionCellModel
            self.collectionView.reloadData()
            
        }
    }
}


// MARK: Extension for UICollectionViewFlowLayout delegate

extension VideosNewViewController: UICollectionViewDelegateFlowLayout {
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


// MARK: Extension for UISearchResultsUpdating

extension VideosNewViewController: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let filtersVC = UIStoryboard(name: "VideosFilters", bundle: nil).instantiateViewController(identifier: "VideosFiltersViewController")
        filtersVC.modalPresentationStyle = .fullScreen
        present(filtersVC, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getVideoList(WithSearchText: nil)
    }
    
}


extension VideosNewViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {
            searchString = searchController.searchBar.text!
            getVideoList(WithSearchText: searchController.searchBar.text!)
        } else {
            getVideoList(WithSearchText: nil)
        }
    }
}

    // MARK: Extension for data loading

extension VideosNewViewController {
    
    // MARK: Get video list
    
    func getVideoList(WithSearchText searchText: String?) {
        self.items.removeAll()
        self.pageHeight = 20
        self.indexPage = 1
        var parameters = getFilters()
        if let searchText = searchText, searchText.count >= 1 {
            parameters["query"] = searchText
        }
        if parameters.count < 1 {
            loadData(withPage: 1)
        } else {
           // parameters["http_status_codes"] = "default"
            parameters["page"] = 1
            loadDataWithFilters(withParameters: parameters)
        }
    }
    
    func getNextVideoList (WithSearchText searchText: String?) {
        var parameters = getFilters()
        if let searchText = searchText, searchText.count >= 1 {
            parameters["query"] = searchText
        }
        if parameters.count < 1 {
            loadData(withPage: indexPage)
        } else {
            parameters["http_status_codes"] = "default"
            parameters["page"] = indexPage
            loadDataWithFilters(withParameters: parameters)
        }
    }
    
    func loadData(withPage page: Int) {
        self.activityIndicator.startAnimating()
        let service = VideosServiceImpl()
        service.getVideoList(onPage: page, andWithType: "last") { [weak self] (response, error) in
            if let `self` = self {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.showAlertWithTitle(error.errorDescription)
                } else {
                    if let rowVideos = response?.rows {
                        let videos = rowVideos.map({VideoCollectionCellModel(rowVideo: $0)})
                        self.items += videos
                    }
                    self.collectionView.reloadData()
                }
            }
        }
        self.collectionView.reloadData()
    }
    
    func loadDataWithFilters(withParameters parameters: Parameters) {       self.activityIndicator.startAnimating()
        let service = VideosServiceImpl()
            service.getVideoListWithFilters(withFilterParameters: parameters) { [weak self] (response, error) in
                if let `self` = self {
                    self.activityIndicator.stopAnimating()
                    if let error = error {
                        self.showAlertWithTitle(error.errorDescription)
                    } else {
                        if let rowVideos = response?.rows {
                            let videos = rowVideos.map({VideoCollectionCellModel(rowVideo: $0)})
                            self.items += videos
                        }
                        self.collectionView.reloadData()
                    }
                }
            }
        self.collectionView.reloadData()
    }
    
    // MARK: Favorites
    
    func addFavorite (withID id: String) {
        let service = FavoriteListServiceImpl()
//        self.activityIndicator.startAnimating()
        service.addFavorite(withID: id) { (response, error) in
//            self.activityIndicator.stopAnimating()
            if let error = error {
                self.showAlertWithTitle(error.errorDescription)
            } else {
            }
        }
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
    
    
    // MARK: Filters
    
    func getFilters() -> Parameters {
        var parameters: Parameters = [:]
        if let savedSortingStr = UserDefaults.standard.string(forKey: "Sorting") {
            if let savedSorting = VideosFilter(JSONString: savedSortingStr) {
                parameters["type"] = savedSorting.id!
            } else {
                parameters["type"] = "last"
            }
        }
        if let savedTypesStr = UserDefaults.standard.string(forKey: "Types") {
            if let savedTypes = Filters(JSONString: savedTypesStr) {
                for (index,filter) in savedTypes.filters!.enumerated() {
                    parameters["vod_type[\(index)]"] = filter.id
                }
            }
        }
        if let savedGenresStr = UserDefaults.standard.string(forKey: "Genres") {
            if let savedGenres = Filters(JSONString: savedGenresStr) {
                for (index,filter) in savedGenres.filters!.enumerated() {
                    parameters["genre[\(index)]"] = filter.id
                }
            }
        }
        if let savedYearsStr = UserDefaults.standard.string(forKey: "Years") {
            if let savedYears = Filters(JSONString: savedYearsStr) {
                for (index,filter) in savedYears.filters!.enumerated() {
                    parameters["year[\(index)]"] = filter.id
                }
            }
        }

        if let savedKinopoiskStr = UserDefaults.standard.string(forKey: "Rating Kinopoisk") {
            if let savedKinopoisk = Filters(JSONString: savedKinopoiskStr) {
                for (index,filter) in savedKinopoisk.filters!.enumerated() {
                    parameters["kinopoisk[\(index)]"] = filter.id
                }
            }
        }
        if let savedIMDBStr = UserDefaults.standard.string(forKey: "Rating IMDB") {
            if let savedIMDB = Filters(JSONString: savedIMDBStr) {
                for (index,filter) in savedIMDB.filters!.enumerated(){
                    parameters["imdb[\(index)]"] = filter.id
                }
            }
        }
        return parameters
    }
}
