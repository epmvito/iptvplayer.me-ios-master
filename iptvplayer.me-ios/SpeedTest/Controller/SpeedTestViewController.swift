//
//  SpeedTestViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 03.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit
import MBProgressHUD
import PKHUD

class SpeedTestViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: PrimaryButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: Private properties
    
    fileprivate var items: [Entity] = []
    var complete: Bool = false
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("speedTest", comment: "")
    
        activityIndicator.stopAnimating()
        activityIndicator.color = .pacificBlue
        setupTableView()
        loadData()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefor")
        if launchedBefore  {
            print("dshdjg")
        } else {
            startButtonTapped(startButton)
            UserDefaults.standard.set(true, forKey: "launchedBefor")
        }
    }
    
    // MARK: Private methods
    
    private func setupTableView() {
        
        let view = UIView()
        view.backgroundColor = .white
        tableView.tableFooterView = view
    
        let cell = UINib(nibName: "ServersTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "ServersTableViewCell")
    }
    
    func returnTheFastestServer() -> Int? {
        var serverSpeed: [Float] = []
        
        for item in items {
            let server = item as! ServerTableCellModel
            let speed = server.speedInfo ?? 0.0
                serverSpeed.append(speed)
        }
        if serverSpeed.isEmpty == false {
            let maxSpeed = serverSpeed.max()
            for (index, item) in items.enumerated() {
                let server = item as! ServerTableCellModel
                if server.speedInfo == maxSpeed {
                    return index
                }
            }
        }
        return nil
    }
    
    // MARK: Actions
    
    @IBAction func startButtonTapped(_ sender: PrimaryButton) {
        startButton.isEnabled = false
//        speedTestingAll()
        speedTestingInCourse()
        loadData()
    }
}

    //MARK: Extension for TableViewDataSource

extension SpeedTestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServersTableViewCell", for: indexPath) as! ServersTableViewCell
        cell.configureWithEntity(entity: item)
        
        return cell
    }
}

    //MARK: Extension for DataLoading

extension SpeedTestViewController: UITableViewDelegate {

    func loadData() {
        
        self.items.removeAll()
        let europeCentral = ServerTableCellModel(name: "Europe Central", serverURL: "https://eu2.sunduk.tv:7575/random2000x2000.jpg", info: nil, speed: nil, progress: nil, cellStyle: .defaultStyle)
        let europeNorth = ServerTableCellModel(name: "Europe North", serverURL: "https://eu3.sunduk.tv:7575/random2000x2000.jpg", info: nil, speed: nil, progress: nil, cellStyle: .defaultStyle)
        let usaSouth = ServerTableCellModel(name: "USA South", serverURL: "https://usa1.sunduk.tv:7575/random2000x2000.jpg", info: nil, speed: nil, progress: nil, cellStyle: .defaultStyle)
        let usaNorth = ServerTableCellModel(name: "USA North", serverURL: "https://usa2.sunduk.tv:7575/random2000x2000.jpg", info: nil, speed: nil, progress: nil, cellStyle: .defaultStyle)
        let israel = ServerTableCellModel(name: "Israel", serverURL: "https://il.sunduk.tv:7575/random2000x2000.jpg", info: nil, speed: nil, progress: nil, cellStyle: .defaultStyle)
//        let asia = ServerTableCellModel(name: "Asia South", serverURL: "http://asia.sunduk.tv:7575/random2000x2000.jpg", info: nil, speed: nil, progress: 0.43, cellStyle: .defaultStyle)
        
        self.items.append(europeCentral)
        self.items.append(europeNorth)
        self.items.append(usaNorth)
        self.items.append(usaSouth)
        self.items.append(israel)
//        self.items.append(asia)
        
        self.tableView.reloadData()
        
    }
    
    func speedTestingAll() {
        for (index, item) in self.items.enumerated() {
            let server = item as! ServerTableCellModel
            let testingService = SpeedTestClient()

            testingService.testDownloadSpeedWithTimout(timeout: 15.0, from: server.serverURL) { [weak self] (mbps, progress, time, error) in
                if let `self` = self {
                    if let error = error {
                        if error.localizedDescription == "The request timed out." {
                            server.cellStyle = .slowConnection
                        } else {
                            server.cellStyle = .error
                        }

                    } else {
                        server.cellStyle = .testing
                        if let mbps = mbps {
                             let roundMbps = (roundf(Float(mbps * 10))) / 10
                            print(roundMbps)
                            server.speedInfo = roundMbps
                        }
                        if let progress = progress {
                            server.progressInfo = progress
                        }
                        if let time = time {
                            server.cellStyle = .successful
                            server.serverInfo = "\(time) sec"
                            }
                        self.items[index] = server
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func setServer(server: String) {

        let service = ServersSettingsImpl()
        self.activityIndicator.startAnimating()
        service.StreamServer(andVar: server) { (response, error) in
            self.activityIndicator.stopAnimating()
            if let error = error {
                self.showAlertWithTitle(error.errorDescription)
                } else {
                HUD.flash(.labeledSuccess(title: nil, subtitle: NSLocalizedString("ServerChanged", comment: "")), delay: 1)
            }
        }
    }
    
    func speedTestingInCourse() {

        let server = items[0] as! ServerTableCellModel
        createService(server: server, withIndex: 0)
        
    }
    
    func endTesting() {
        self.tableView.reloadData()
        self.startButton.isEnabled = true
        if let fastestIndex = self.returnTheFastestServer() {
            let fastestServer = self.items[fastestIndex] as! ServerTableCellModel
            print ("allComplete, mostSpeed is \(fastestServer.serverName) ")
            showYesNoAlertWithTitle(NSLocalizedString("BestResult", comment: ""), andAlertMessage: "\(fastestServer.serverName) \n \(fastestServer.speedInfo ?? 0.0) Mbps \n Set server as selected?") { (action) in
                self.setServer(server: fastestServer.serverName)
                let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefo")
                if launchedBefore  {
                    print("dshdjg")
                } else {
                    let speedTestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TVVC")
                    self.navigationController?.pushViewController(speedTestVC, animated: true)
                    UserDefaults.standard.set(true, forKey: "launchedBefo")
                }
            }
        }
    }
    
    func createService(server: ServerTableCellModel, withIndex index: Int) {
        let testingService = SpeedTestClient()
        testingService.testDownloadSpeedWithTimout(timeout: 15.0, from: server.serverURL) { [weak self] (mbps, progress, time, error) in
            self?.complete = false
            if let `self` = self {
                if let error = error {
                    if error.localizedDescription == NSLocalizedString("RequestTimedOut", comment: "") {
                        server.cellStyle = .slowConnection
                        self.items[index] = server

                    } else {
                        server.cellStyle = .error
                        self.items[index] = server
                    }
                    self.tableView.reloadData()
                    if index+1 < self.items.count {
                    self.testNext(index: index+1, server: self.items[index+1] as! ServerTableCellModel)
                    } else {
                        self.endTesting()
                    }
                } else {
                    server.cellStyle = .testing
                    if let mbps = mbps {
                       // (roundf(Float(mbps * 10))) / 10
                         let roundMbps = (roundf(Float(mbps * 100))) / 10
                        print(roundMbps)
                        server.speedInfo = roundMbps
                        self.items[index] = server

                    }
                    if let progress = progress {
                        server.progressInfo = progress
                        self.items[index] = server

                    }
                    if let time = time {
                        server.cellStyle = .successful
                        server.serverInfo = "\(time) sec"
                        self.items[index] = server
                        if index+1 < self.items.count {
                        self.testNext(index: index+1, server: self.items[index+1] as! ServerTableCellModel)
                        } else {
                            self.endTesting()
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func testNext(index: Int, server: ServerTableCellModel) {
        let testingService = SpeedTestClient()
        testingService.testDownloadSpeedWithTimout(timeout: 15.0, from: server.serverURL) { [weak self] (mbps, progress, time, error) in
            self?.complete = false
            if let `self` = self {
                if let error = error {
                    if error.localizedDescription == NSLocalizedString("RequestTimedOut", comment: ""){
                        server.cellStyle = .slowConnection
                        self.items[index] = server

                    } else {
                        server.cellStyle = .error
                        self.items[index] = server

                    }
                    if index+1 < self.items.count {
                    self.createService(server: self.items[index+1] as! ServerTableCellModel, withIndex: index+1)
                    } else {
                        self.endTesting()
                    }
                } else {
                    server.cellStyle = .testing
                    if let mbps = mbps {
                         let roundMbps = (roundf(Float(mbps * 10))) / 10
                        server.speedInfo = roundMbps
                        self.items[index] = server
                    }
                    if let progress = progress {
                        server.progressInfo = progress
                        self.items[index] = server
                    }
                    if let time = time {
                        server.cellStyle = .successful
                        server.serverInfo = "\(time) sec"
                        self.items[index] = server
                        if index+1 < self.items.count {
                        self.createService(server: self.items[index+1] as! ServerTableCellModel, withIndex: index+1)
                        } else {
                            self.endTesting()
                        }
                    }
                    self.items[index] = server
                    self.tableView.reloadData()
                }
            }
        }
    }
}


