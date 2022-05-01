    //
//  ServersTableViewCell.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 03.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class ServersTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var serverNameLabel: UILabel!
    @IBOutlet weak var serverSpeedLabel: UILabel!
    @IBOutlet weak var serverInfoLabel: UILabel!
    @IBOutlet weak var loadingProgressView: UIProgressView!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var progressView: UIView!
    
    
    // MARK: Lyfecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadingProgressView.tintColor = UIColor.pacificBlue
        setDefaultStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureWithEntity(entity: Entity) {
        let server = entity as! ServerTableCellModel

        switch server.cellStyle {
        case .defaultStyle:
            setDefaultStyle()
        case .testing:
            setTestingStyle()
        case .successful:
            setSuccessfulStyle(withTime: server.serverInfo ?? "Error")
        case .error:
            setErrorStyle()
        case .slowConnection:
            setSlowConnectionStyle()
        }
        serverNameLabel.text = server.serverName
        loadingProgressView.progress = server.progressInfo ?? 0.0
        serverSpeedLabel.text = "\(server.speedInfo ?? 0.0) Mbps"
    }
}

    //MARK: Extension for Style

extension ServersTableViewCell {
    
    
    func setDefaultStyle() {
        serverSpeedLabel.isHidden = true
        infoView.isHidden = true
        progressView.isHidden = true
    }
    
    func setTestingStyle() {
        serverSpeedLabel.isHidden = false
        infoView.isHidden = true
        progressView.isHidden = false
    }
    
    func setErrorStyle() {
        serverSpeedLabel.isHidden = false
        infoView.isHidden = false
        progressView.isHidden = false
        
        serverInfoLabel.text = "Error"
    }
    
    func setSuccessfulStyle(withTime time: String) {
        serverSpeedLabel.isHidden = false
        infoView.isHidden = false
        progressView.isHidden = false
        
        serverInfoLabel.text = time
    }
    
    func setSlowConnectionStyle() {
        serverSpeedLabel.isHidden = false
        infoView.isHidden = false
        progressView.isHidden = false
        
        serverInfoLabel.text = NSLocalizedString("SlowConnection", comment: "")
    }
}

