//
//  DownloadViewController.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 01.05.2022.
//  Copyright © 2022 Никита. All rights reserved.
//
import Foundation
import UIKit

class DownloadViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var gg: PlaylistModeViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Download"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        func listFilesFromDocumentsFolder() -> [String]
//        {
//            let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
//            if dirs != [] {
//                let dir = dirs[0]
//                let fileList = try! FileManager.default.contentsOfDirectory(atPath: dir)
//                return fileList
//            }else{
//                let fileList = [""]
//                return fileList
//            }
//        }
//        let fileManager:FileManager = FileManager.default
//            let fileList = listFilesFromDocumentsFolder()
//
//            let count = fileList.count
//
//            for i in 0..<count
//            {
//                if fileManager.fileExists(atPath: fileList[i]) != true
//                {
//                    print("File is \(fileList[i])")
//                }
//            }
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            // process files
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        print(FileManager.default.urls(for: .documentDirectory) ?? "none")
        
        return cell
    }
    
}

extension FileManager {
    func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {
        let documentsURL = urls(for: directory, in: .userDomainMask)[0]
        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs
    }
}


