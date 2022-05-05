//
//  DownloadViewController.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 01.05.2022.
//  Copyright © 2022 Никита. All rights reserved.
//
import Foundation
import UIKit

var videoFileLis:[RowVideoDataItem] = [RowVideoDataItem]()

class DownloadViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var gg: PlaylistModeViewController!
    
    var how: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Download"
        listVideos()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func listVideos() -> [URL] {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let files = try? fileManager.contentsOfDirectory(
            at: documentDirectory,
            includingPropertiesForKeys: nil,
            options: [.skipsSubdirectoryDescendants, .skipsHiddenFiles]
        ).filter {
            ["mp4"].contains($0.pathExtension.lowercased())
        }
        print(files)

        return files ?? []
    }
    
}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "lohi", for: indexPath)
        
        
        
        return cell
    }
    
}

