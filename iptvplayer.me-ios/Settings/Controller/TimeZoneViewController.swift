//
//  TimeZoneViewController.swift
//  iptvplayer.me-ios
//
//  Created by Ilya Egorov on 17.04.2022.
//  Copyright © 2022 Никита. All rights reserved.
//

import Foundation
import UIKit

class TimeZoneViewController: UIViewController{
    
    
    @IBOutlet weak var value: UILabel!
    
    @IBAction func slider(_ sender: UISlider) {
        value.text = String(Int(sender.value))
    }
    
    var currentChannel: RowSettings!
    private var urlString = ""
    private var value1 = 0
    private let webClient = WebClient<BaseResponse>()
    private var currentProgram: Program! {
        didSet {
            guard let channel = currentChannel else { return }
            if let cid = channel.timezone{
                webClient.requestSettings(timeshift: nil, timezone: cid, bitrate: nil, bitratehd: nil, vod_bitrate: nil) { [weak self] stringURL in
                    guard let self = self else { return }
                    self.urlString = stringURL
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("TimeZones", comment: "")
    }
    
    func reqWebClient(){
        guard let channel = currentChannel else { return }
        if let cid =  channel.timezone{
            webClient.requestSettings(timeshift: nil, timezone: cid, bitrate: nil, bitratehd: nil, vod_bitrate: cid) { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
            }
        }
    }
    
}
