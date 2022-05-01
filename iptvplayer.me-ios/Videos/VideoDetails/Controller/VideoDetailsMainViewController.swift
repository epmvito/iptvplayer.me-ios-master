//
//  VideoDetailsMainViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 23.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit
import Pageboy
import Tabman

class VideoDetailsMainViewController: TabmanViewController {
    
    private var viewControllers = [UIViewController]()
    public var id: String = ""
    public var isFavorite: Bool = false
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoVC = UIStoryboard(name: "VideoDetails", bundle: nil).instantiateViewController(identifier: "VideoDetailsInformationViewController") as! VideoDetailsInformationViewController
        infoVC.title = NSLocalizedString("information", comment: "")
        infoVC.id = id
        let filesVC = UIStoryboard(name: "VideoDetails", bundle: nil).instantiateViewController(identifier: "VideoDetailsFilesViewController") as! VideoDetailsFilesViewController
        filesVC.title = NSLocalizedString("files", comment: "")
        filesVC.id = id
        
        viewControllers.append(infoVC)
        viewControllers.append(filesVC)
        
        setupBarButton()
        
        self.dataSource = self
        barCustomize()
        
    }
    
    // MARK: Methods
    
    func setupBarButton() {
        if isFavorite {
            let favoriteButtonItem = UIBarButtonItem(image: UIImage(named: "heartFull"), style: .done, target: self, action: #selector(deleteFavoriteButtonTapped))
            favoriteButtonItem.tintColor = .pacificBlue
            navigationItem.rightBarButtonItems = [favoriteButtonItem]
        } else {
            let favoriteButtonItem = UIBarButtonItem(image: UIImage(named: "heart"), style: .done, target: self, action: #selector(addFavoriteButtonTapped))
            favoriteButtonItem.tintColor = .pacificBlue
            navigationItem.rightBarButtonItems = [favoriteButtonItem]
        }
    }
    
    func barCustomize() {
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.backgroundColor = .clear
        bar.backgroundView.style = .flat(color: .clear)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -5.0, right: 0.0)
        bar.indicator.tintColor = .pacificBlue
        bar.indicator.weight = .light
        bar.layout.contentMode = .fit
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray
            button.selectedTintColor = .pacificBlue
        }
        addBar(bar, dataSource: self, at: .top)
    }
    
    // MARK: Favorites
        
        func addFavorite (withID id: String) {
            let service = FavoriteListServiceImpl()
            service.addFavorite(withID: id) { (response, error) in
                if let error = error {
                    self.showAlertWithTitle(error.errorDescription)
                } else {
                }
            }
        }
        
        func deleteFavorite (withID id: String) {
            let service = FavoriteListServiceImpl()
            service.deleteFavorite(withID: id) { (response, error) in
            if let error = error {
                    self.showAlertWithTitle(error.errorDescription)
            } else {
                }
            }
        }
    
    
    // MARK: Actions
    
    @objc func addFavoriteButtonTapped(_ sender: UIBarButtonItem) {
        isFavorite = true
        addFavorite(withID: id)
        setupBarButton()
    }
    
    @objc func deleteFavoriteButtonTapped(_ sender: UIBarButtonItem) {
        isFavorite = false
        deleteFavorite(withID: id)
        setupBarButton()
    }

    
}

    // MARK: Extension for TabmanDataSource

extension VideoDetailsMainViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = viewControllers[index].title ?? ""
        return TMBarItem(title: title)
    }
}
