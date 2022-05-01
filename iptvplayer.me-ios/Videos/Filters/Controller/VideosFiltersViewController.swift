//
//  VideosFiltersViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 16.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class VideosFiltersViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    private var items: [Entity] = []
    
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("filters", comment: "")
        
        setupTableView()
        loadData()
    }
    
    // MARK: Methods
    
    private func setupTableView() {
        
        let view = UIView()
        view.backgroundColor = .white
        tableView.tableFooterView = view
        tableView.delegate = self
    
        let cell = UINib(nibName: "VideosFilterTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "VideosFilterTableViewCell")
    }
    
    func deleteFilters() {
        UserDefaults.standard.removeObject(forKey: "Sorting")
        UserDefaults.standard.removeObject(forKey: "Types")
        UserDefaults.standard.removeObject(forKey: "Genres")
        UserDefaults.standard.removeObject(forKey: "Years")
        UserDefaults.standard.removeObject(forKey: "Rating Kinopoisk")
        UserDefaults.standard.removeObject(forKey: "Rating IMDB")
        loadData()
    }
    
    // MARK: Actions
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func clearButtonTapped(_ sender: PrimaryButton) {
        deleteFilters()
    }
    
    @IBAction func applyButtonTapped(_ sender: MainButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: Extension for UITableViewDataSource

extension VideosFiltersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideosFilterTableViewCell", for: indexPath) as! VideosFilterTableViewCell
        cell.configureWithEntity(item)
        cell.delegate = self
        
        return cell
        
    }
}
    // MARK: Extension for VideosFilterDetailsViewControllerDelegate

extension VideosFiltersViewController: VideosFilterDetailsViewControllerDelegate {
    func backBauttonSaveTapped(_ filterItem: VideosFilterTableCellModel) {
        for (index, item) in items.enumerated() {
            let filter = item as! VideosFilterTableCellModel
            if filter.filterName == filterItem.filterName {
                self.items[index] = filterItem
                self.tableView.reloadData()
            }
        }
    }
}

    // MARK: Extension for UITableViewDelegate

extension VideosFiltersViewController: VideosFilterTableViewCellDelegate {
    func cellTapped(_ cell: VideosFilterTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let item = self.items[indexPath.row] as! VideosFilterTableCellModel
            
            let filterDetailVC = UIStoryboard(name: "VideosFilters", bundle: nil).instantiateViewController(identifier: "VideosFilterDetailsViewController") as! VideosFilterDetailsViewController
            filterDetailVC.delegate = self
            filterDetailVC.filter = item
            filterDetailVC.modalPresentationStyle = .fullScreen
            filterDetailVC.modalTransitionStyle = .crossDissolve
            present(filterDetailVC, animated: true)
        }
    }
}

extension VideosFiltersViewController: UITableViewDelegate {

}

    // MARK: Extension for loadData

extension VideosFiltersViewController {
    func loadData() {
        items.removeAll()
        
        if let savedSortingStr = UserDefaults.standard.string(forKey: "Sorting") {
            if let savedSorting = VideosFilter(JSONString: savedSortingStr) {
                let sorting = VideosFilterTableCellModel(filterName: "Sorting", selected: savedSorting.id!)
                self.items.append(sorting)
            }
        } else {
            let sorting = VideosFilterTableCellModel(filterName: "Sorting", selected: "last")
            self.items.append(sorting)
        }
        if let savedTypesStr = UserDefaults.standard.string(forKey: "Types") {
            if let savedTypes = Filters(JSONString: savedTypesStr) {
                let types = VideosFilterTableCellModel(filterName: "Types", selected: savedTypes.selectedString!)
                self.items.append(types)
            }
        } else {
            let types = VideosFilterTableCellModel(filterName: "Types", selected: "All")
            self.items.append(types)
        }
        if let savedGenresStr = UserDefaults.standard.string(forKey: "Genres") {
            if let savedGenres = Filters(JSONString: savedGenresStr) {
                let genres = VideosFilterTableCellModel(filterName: "Genres", selected: savedGenres.selectedString!)
                self.items.append(genres)
            }
        } else {
            let genres = VideosFilterTableCellModel(filterName: "Genres", selected: "All")
            self.items.append(genres)
        }
        if let savedYearsStr = UserDefaults.standard.string(forKey: "Years") {
            if let savedYears = Filters(JSONString: savedYearsStr) {
            let years = VideosFilterTableCellModel(filterName: "Years", selected: savedYears.selectedString!)
                self.items.append(years)
            }
        } else {
            let years = VideosFilterTableCellModel(filterName: "Years", selected: "All")
            self.items.append(years)
        }

        if let savedKinopoiskStr = UserDefaults.standard.string(forKey: "Rating Kinopoisk") {
            if let savedKinopoisk = Filters(JSONString: savedKinopoiskStr) {
                let kinopoisk = VideosFilterTableCellModel(filterName: "Rating Kinopoisk", selected: savedKinopoisk.selectedString!)
                self.items.append(kinopoisk)
            }
        } else {
            let kinopoisk = VideosFilterTableCellModel(filterName: "Rating Kinopoisk", selected: "All")
            self.items.append(kinopoisk)
        }
        if let savedIMDBStr = UserDefaults.standard.string(forKey: "Rating IMDB") {
            if let savedIMDB = Filters(JSONString: savedIMDBStr) {
                let imdb = VideosFilterTableCellModel(filterName: "Rating IMDB", selected: savedIMDB.selectedString!)
                self.items.append(imdb)
            }
        } else {
            let imdb = VideosFilterTableCellModel(filterName: "Rating IMDB", selected: "All")
            self.items.append(imdb)
        }

        self.tableView.reloadData()
    }
}
