//
//  VideoDetailsFilesViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 23.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//
import UIKit
import AVKit
import AVFoundation
import Foundation

var videoFileList:[RowVideoDataItem] = [RowVideoDataItem]()

class VideoDetailsFilesViewController: UIViewController {
    
    var downloadBtn: VideoPlayerViewController!
    
    @IBOutlet weak var videoTableView: UITableView!

    public var id: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoTableView.delegate = self
        videoTableView.dataSource = self
        title = NSLocalizedString("files", comment: "")
        
        }
  
    
}

extension VideoDetailsFilesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoFileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = videoTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VideoFileTableViewCell
        cell.formatNo.text = "\(indexPath.row)"
        cell.formatName.text = videoFileList[indexPath.row].format
        
        return cell
        
    }
    
   
    
    @IBAction func clickBtn(_ sender: Any){
        let documentsURL = NSURL(
          fileURLWithPath: NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true).last!,
          isDirectory: true
        )
        print("\(documentsURL)ddddddddddddddddddddddd")
        let URLToMyFile = documentsURL.appendingPathExtension("83.mp4")
        print(URLToMyFile)
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        let url = URLToMyFile!
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filesVC = UIStoryboard(name: "VideoDetails", bundle: nil).instantiateViewController(identifier: "VideoPlayerViewController") as! VideoPlayerViewController
        filesVC.currentChannel = videoFileList[indexPath.row]
        navigationController?.pushViewController(filesVC, animated: true)
    }
}

