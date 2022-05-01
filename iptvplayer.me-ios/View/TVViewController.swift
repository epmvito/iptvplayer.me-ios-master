//
//  TVViewController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 13.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class TVViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let spinner = UIActivityIndicatorView()
    var channelsList = [Category]()
    let webClient = WebClient<BaseResponse>()
    var selectedChannel: Channel!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLoadingSpinner()
        webClient.requestChannelsList { [weak self] listOfChannels in
            self?.populateChannelsListWithData(from: listOfChannels)
            
        }
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            print("gg")
        } else {
            let speedTestVC = UIStoryboard(name: "SpeedTest", bundle: nil).instantiateViewController(identifier: "SpeedTestViewController")
            self.navigationController?.pushViewController(speedTestVC, animated: true)
            print("hh")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    private func startLoadingSpinner() {
        spinner.center = view.center
        spinner.color = .pacificBlue
        spinner.style = .large
        view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func stopLoadingSpinner() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    private func populateChannelsListWithData(from source: ChannelsList) {
        guard let groups = source.groups else { return }
        channelsList = []
        for group in groups {
            channelsList.append(Category(isExpanded: false, category: group.name!, channels: group.channels!))
        }
        self.tableView.reloadData()
        self.stopLoadingSpinner()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard selectedChannel != nil else { return }
        if segue.identifier == "Open TV Player" {
            if let destination = segue.destination as? TVPlayerViewController {
                destination.currentChannel = selectedChannel
                let today = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "ddMMyy"
                webClient.requestPrograms(forChannel: selectedChannel.id!, date: dateFormatter.string(from: today)) { programsList in
                    destination.programs = programsList.epg
                }
            }
        }
    }
}

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectedChannel = channelsList[indexPath.section].channels[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "Open TV Player", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "section") as! ChannelCategoryCell

        cell.title = channelsList[section].category
        cell.contentView.tag = section
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleExpandClose))
        cell.contentView.addGestureRecognizer(tapGesture)

        return cell.contentView
    }
    
    @objc func handleExpandClose(sender: UITapGestureRecognizer) {
        startLoadingSpinner()
        let sectionId = sender.view!.tag
        
        var indexPaths = [IndexPath]()
        
        for row in channelsList[sectionId].channels.indices {
            indexPaths.append(IndexPath(row: row, section: sectionId))
        }

        self.stopLoadingSpinner()
        let isExpanded = channelsList[sectionId].isExpanded
        channelsList[sectionId].isExpanded = !isExpanded
        
        if let cellContentView = sender.view {
            if let folderImageView = cellContentView.subviews.first as? UIImageView {
                folderImageView.image = channelsList[sectionId].isExpanded ? UIImage(named: "folder_open") : UIImage(named: "folder")
            }
            if let expandAndCollapseImageView = cellContentView.subviews.last as? UIImageView {
                expandAndCollapseImageView.image = channelsList[sectionId].isExpanded ? UIImage(named: "close") : UIImage(named: "expand")
            }
        }
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return channelsList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if channelsList[section].isExpanded {
            return channelsList[section].channels.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChannelCell
        let channel = channelsList[indexPath.section].channels[indexPath.row]
        cell.setupCell1(channelList: channel)
        
//        if let iconURL = URL(string: channel.icon_url!) {
//            if let iconImageData = try? Data(contentsOf: iconURL) {
//                cell.setupCell(channelName: channel.name!, program: channel.epg_progname!, channelLogo: (UIImage(data: iconImageData) ?? UIImage(systemName: "video.slash.fill"))!)
//            }
//
//
//            if let iconImageData = try? Data(contentsOf: iconURL) {
//                cell.setupCell(channelName: channel.name!, program: channel.epg_progname!, channelLogo: UIImage(systemName: "video.slash.fill")!)
//            }


        //}
        return cell
    }
}
