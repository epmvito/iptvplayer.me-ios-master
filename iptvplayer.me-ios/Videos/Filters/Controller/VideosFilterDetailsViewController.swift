//
//  VideosFilterDetailsViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 17.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

protocol VideosFilterDetailsViewControllerDelegate: class {
    func backBauttonSaveTapped(_ filterItem: VideosFilterTableCellModel)
}

class VideosFilterDetailsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    private var items: [Entity] = []
    
    public var filter: VideosFilterTableCellModel = VideosFilterTableCellModel(filterName: "Sorting", selected: "last")
    public var delegate: VideosFilterDetailsViewControllerDelegate?
    
    // MARK: Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = UIColor.pacificBlue
        titleLabel.text = filter.filterName
        activityIndicator.color = UIColor.pacificBlue
        activityIndicator.stopAnimating()
        
        setupTableView()
        loadData()
    }
    
    // MARK: Methods
    
    private func setupTableView() {
                
        let view = UIView()
        view.backgroundColor = .white
        tableView.tableFooterView = view
    
        let cell = UINib(nibName: "VideosFilterDetailsTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "VideosFilterDetailsTableViewCell")
        let cell2 = UINib(nibName: "VideosFilterSortingTableViewCell", bundle: nil)
        tableView.register(cell2, forCellReuseIdentifier: "VideosFilterSortingTableViewCell")
    }
    
    func checkSelected() {
        if filter.filterName != "Sorting" {
            var selectArray: [String] = []
            var selectFilters: [VideosFilter] = []
            for item in items {
                let videosFilterDetailsTableCellModel = item as! VideosFilterDetailsTableCellModel
                if videosFilterDetailsTableCellModel.isSelected! {
                    selectArray.append(videosFilterDetailsTableCellModel.name)
                    let selectedFilter = VideosFilter(id: videosFilterDetailsTableCellModel.id, name: self.filter.filterName)
                    selectFilters.append(selectedFilter)
                }
            }
            let filters = Filters(filters: selectFilters, selectedString: "")
            var selectString: String = ""
            for str in selectArray {
                selectString +=  str + ", "
            }
            if selectString.count > 2 {
                selectString.removeLast()
                selectString.removeLast()
                filters.selectedString = selectString
                let filtersString = filters.toJSONString(prettyPrint: true)
//                print (filtersString!)
                UserDefaults.standard.set(filtersString, forKey: filter.filterName)
                UserDefaults.standard.synchronize()
            } else {
                selectString = "All"
                UserDefaults.standard.removeObject(forKey: filter.filterName)
            }
            self.filter.selected = selectString
        } else {
            if filter.selected == "best" {
                let videosFilter = VideosFilter(id: filter.selected, name: "type")
                let videosFilterString = videosFilter.toJSONString(prettyPrint: true)
                UserDefaults.standard.set(videosFilterString, forKey: filter.filterName)
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.removeObject(forKey: filter.filterName)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        checkSelected()
        delegate?.backBauttonSaveTapped(filter)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Extension for UITableViewDataSource

extension VideosFilterDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if filter.filterName == "Sorting" {
            let item = items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideosFilterSortingTableViewCell", for: indexPath) as! VideosFilterSortingTableViewCell
                cell.configureWithEntity(item)
            cell.delegate = self
            return cell
        } else {
            let item = items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideosFilterDetailsTableViewCell", for: indexPath) as! VideosFilterDetailsTableViewCell
            cell.configureWithEntity(item)
        cell.delegate = self
            return cell
        }
    }
}

// MARK: Extension for TableView Delegate

extension VideosFilterDetailsViewController: VideosFilterSortingTableViewCellDelegate {
    func selectButton(_ cell: VideosFilterSortingTableViewCell, isLastSelected: Bool) {
        if isLastSelected {
            filter.filterName = "Sorting"
            filter.selected = "last"
        } else {
            filter.filterName = "Sorting"
            filter.selected = "best"
        }
    }
}

extension VideosFilterDetailsViewController: VideosFilterDetailsTableViewCellDelegate {
    func checkBoxHasBeenSelected(_ cell: VideosFilterDetailsTableViewCell, name: String, isSelected: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            let item = self.items[indexPath.row] as! VideosFilterDetailsTableCellModel
            item.name = name
            item.isSelected = isSelected
            self.items[indexPath.row] = item
            self.tableView.reloadData()
        }
    }
}

// MARK: Extension for dataLoading

extension VideosFilterDetailsViewController {
    func loadData() {
        switch filter.filterName {
        case "Sorting":
            if let savedSorting = UserDefaults.standard.string(forKey: filter.filterName) {
                let savedFilter = VideosFilter(JSONString: savedSorting)
                self.filter.selected = savedFilter!.id!
                self.items.removeAll()
                self.items.append(filter)
            } else {
                self.items.removeAll()
                self.items.append(filter)
            }
        case "Types":
            getList(withFilterName: "types")
        case "Genres":
            getList(withFilterName: "genres")
        case "Years":
            getList(withFilterName: "years")
        case "Rating Kinopoisk":
            getList(withFilterName: "kinopoisk")
        case "Rating IMDB":
            getList(withFilterName: "imdb")
        default:
            print("Error")
            
        }
    }
    
    func getList(withFilterName name: String) {
        if let filter = UserDefaults.standard.string(forKey: name) {
            print ("\(filter)")
        }
        self.activityIndicator.startAnimating()
        let service = GetFiltersImpl()
        service.getFiltersList(withFilterName: name) { [weak self] (response, error) in
            if let `self` = self {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.showAlertWithTitle(error.errorDescription)
                } else {
                    if let types = response?.types {
                        let newItems = types.map({VideosFilterDetailsTableCellModel(videosFilter: $0, isSelected: false)})
                        self.items = newItems
                    } else if let genres = response?.genres {
                        let newItems = genres.map({VideosFilterDetailsTableCellModel(videosFilter: $0, isSelected: false)})
                        self.items = newItems
                    } else if let years = response?.years {
                        let newItems = years.map({VideosFilterDetailsTableCellModel(videosFilter: $0, isSelected: false)})
                        self.items = newItems
                        
                    } else if let kinopoisk = response?.kinopoisk {
                        let newItems = kinopoisk.map({VideosFilterDetailsTableCellModel(videosFilter: $0, isSelected: false)})
                        self.items = newItems
                    } else if let imdb = response?.imdb {
                        let newItems = imdb.map({VideosFilterDetailsTableCellModel(videosFilter: $0, isSelected: false)})
                        self.items = newItems
                    }
                    if let savedFilters = UserDefaults.standard.string(forKey: self.filter.filterName) {
                        if let filters = Filters(JSONString: savedFilters) {
                            for (index,item) in self.items.enumerated() {
                                let serverFilter = item as! VideosFilterDetailsTableCellModel
                                for filter in filters.filters! {
                                    if serverFilter.id == filter.id {
                                        serverFilter.isSelected = true
                                        self.items[index] = serverFilter
                                    }
                                }
                            }
                        }
                        self.tableView.reloadData()
                    } else {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
