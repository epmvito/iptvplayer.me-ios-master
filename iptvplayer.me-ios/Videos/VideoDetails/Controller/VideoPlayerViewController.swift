//
//  VideoPlayerViewController.swift
//  iptvplayer.me-ios
//
//  Created by deep on 14/04/22.
//  Copyright © 2022 Никита. All rights reserved.
//

import UIKit
import VersaPlayer
import AVKit
import AVFoundation
import Foundation

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playerView: VersaPlayerView!
    var videoURL: URL?
    var resumeData: Data?
    var array = Array(arrayLiteral: URL.self)
    
    @IBOutlet var controls: VersaPlayerControls!
    var currentChannel: RowVideoDataItem!
    private var urlString = ""
    private var value = 0
    private let webClient = WebClient<BaseResponse>()
    private var currentProgram: Program! {
        didSet {
            guard let channel = currentChannel else { return }
            if let cid = channel.id ,let formetName = channel.format{

                webClient.requestVideoURL(forVideo: cid, formetName: formetName, withStartTime: String(currentProgram.ut_start!), andProtocol: "download") { [weak self] stringURL in
                    guard let self = self else { return }
                    self.urlString = stringURL
                    self.setItemPlayerView(videoURL: self.urlString)
                }
            }
        }
    }
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let downloadService = DownloadService()
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let channel = currentChannel else { return }
        playerView.layer.backgroundColor = UIColor.black.cgColor
        setControls()
        playerView.use(controls: controls)
        if let cid = channel.id ,let formetName = channel.format{
            
            webClient.requestVideoURL(forVideo: cid, formetName: formetName, andProtocol: "download") { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
                self.setItemPlayerView(videoURL: self.urlString)
               
                print(self.urlString)
            }
        }
        
        downloadService.downloadsSession = downloadsSession
    }
    
    func localFilePath(for url: URL) -> URL {
      return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
    
    @IBAction func cancleBtn(_ sender: Any) {
        let movie = Movie(url: URL(string: urlString)!)
        downloadService.cancelDownload(movie)
    }
    
    @IBAction func resumeBtn(_ sender: Any) {
        let movie = Movie(url: URL(string: urlString)!)
        downloadService.resumeDownload(movie)
    }
    
    
    @IBAction func pauseBtn(_ sender: Any) {
        let movie = Movie(url: URL(string: urlString)!)
        downloadService.pauseDownload(movie)
    }
    
    @IBAction func downloadBtn(_ sender: Any) {
        let movie = Movie(url: URL(string: urlString)!)
//        array.append(movie.url)
//        print("\(array)yyyyyyyyyyyyyyyyyyyyyyyy")
        downloadService.startDownload(movie)
    }
    
     func play() {
        let movie = Movie(url: URL(string: urlString)!)
        playDownload(movie)
    }
    
    
    func playDownload(_ movie: Movie){
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        
        let url = localFilePath(for: movie.url)
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    private func setItemPlayerView(videoURL: String) {
        if let url = URL(string: videoURL) {
            let item = VersaPlayerItem(url: url)
            playerView.set(item: item)
        }
    }
    
    
    @objc func fullscreenButtonTouched() {
        print(playerView.frame.size)
    }
    
    private func setControls() {
        controls.fullscreenButton?.addTarget(self, action: #selector(fullscreenButtonTouched), for: .touchDown)
    }

}

extension VideoPlayerViewController: URLSessionDownloadDelegate {
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didFinishDownloadingTo location: URL) {
    // 1
    guard let sourceURL = downloadTask.originalRequest?.url else {
      return
    }
    
    let download = downloadService.activeDownloads[sourceURL]
    downloadService.activeDownloads[sourceURL] = nil
    
    // 2
    let destinationURL = localFilePath(for: sourceURL)
    print(destinationURL)
    
    // 3
    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)
    
    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      download?.movie.downloaded = true
    } catch let error {
      print("Could not copy file to disk: \(error.localizedDescription)")
    }
    
  }
  
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else {
                // Handle success case.
                return
            }
            let userInfo = (error as NSError).userInfo
            if let resumeData = userInfo[NSURLSessionDownloadTaskResumeData] as? Data {
//                self.resumeData = resumeData
                guard let url = task.originalRequest?.url else{
                    return
                }
                self.downloadService.activeDownloads[url]?.resumeData = resumeData
            }
    }
    
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                  totalBytesExpectedToWrite: Int64) {
    // 1
    guard
      let url = downloadTask.originalRequest?.url,
      let download = downloadService.activeDownloads[url]  else {
        return
    }
    
    // 2
    download.progress = (roundf(Float(totalBytesWritten))) / (roundf(Float(totalBytesExpectedToWrite)))
    // 3
    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
    
      
    let progress = (roundf(Float(totalBytesWritten))) / (roundf(Float(totalBytesExpectedToWrite)))
    DispatchQueue.main.async { [weak self] in
          self?.progressBar.progress = progress
          self?.progressLbl.text = "\(progress * 100)%"
      }
  }
}
