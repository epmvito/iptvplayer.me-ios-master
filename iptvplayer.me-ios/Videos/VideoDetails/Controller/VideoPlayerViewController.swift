//
//  VideoPlayerViewController.swift
//  iptvplayer.me-ios
//
//  Created by deep on 14/04/22.
//  Copyright © 2022 Никита. All rights reserved.
//

import UIKit
import VersaPlayer



class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var playerView: VersaPlayerView!
    
    @IBOutlet var controls: VersaPlayerControls!
    var currentChannel: RowVideoDataItem!
    private var urlString = ""
    private var value = 0
    private let webClient = WebClient<BaseResponse>()
    private var currentProgram: Program! {
        didSet {
            guard let channel = currentChannel else { return }
            if let cid = channel.id ,let formetName = channel.format{

                webClient.requestVideoURL(forVideo: cid, formetName: formetName, withStartTime: String(currentProgram.ut_start!), andProtocol: "hls") { [weak self] stringURL in
                    guard let self = self else { return }
                    self.urlString = stringURL
                    self.setItemPlayerView(videoURL: self.urlString)
                //    self.updateUIForCurrentProgram()
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let channel = currentChannel else { return }
        playerView.layer.backgroundColor = UIColor.black.cgColor
        setControls()
        playerView.use(controls: controls)
        if let cid = channel.id ,let formetName = channel.format{
            
            webClient.requestVideoURL(forVideo: cid, formetName: formetName) { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
                self.setItemPlayerView(videoURL: self.urlString)
        
    }
        
    }
        
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
        
//        controls.rewindButton?.tag = 0
//        controls.rewindButton?.addTarget(self, action: #selector(switchVideo(sender:)), for: .touchDown)
//        
//        controls.forwardButton?.tag = 1
//        controls.forwardButton?.addTarget(self, action: #selector(switchVideo(sender:)), for: .touchDown)
    }

}
