//
//  TVPlayerViewController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 22.09.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit
import VersaPlayer

enum Direction {
    case forward
    case backward
}

class TVPlayerViewController: UIViewController {

    //MARK: Objects:
    var currentChannel: Channel!
    var programs: [Program]! { didSet { tableView.reloadData() } }
    
    private var urlString = ""
    private var value = 0
    private let webClient = WebClient<BaseResponse>()
    private var currentProgram: Program! {
        didSet {
            guard let channel = currentChannel else { return }
            if let cid = channel.id {
                webClient.requestURL(forChannel: cid, withStartTime: String(currentProgram.ut_start!), andProtocol: "download") { [weak self] stringURL in
                    guard let self = self else { return }
                    self.urlString = stringURL
                    self.setItemPlayerView(videoURL: self.urlString)
                    self.updateUIForCurrentProgram()
                    print(self.urlString)
                }
            }
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playerView: VersaPlayerView!
    @IBOutlet var controls: VersaPlayerControls!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBAction func switchVideoAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectNextProgram(flipping: .backward, forSameDay: false)
        case 1:
            selectNextProgram(flipping: .forward, forSameDay: false)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let channel = currentChannel else { return }
        tableView.delegate = self
        tableView.dataSource = self
        title = channel.name
        playerView.layer.backgroundColor = UIColor.black.cgColor
        setControls()
        playerView.use(controls: controls)
        
        if let cid = channel.id {
            webClient.requestURL(forChannel: cid, andProtocol: "download") { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
                self.setItemPlayerView(videoURL: self.urlString)
                print(self.urlString)

            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectNextProgram()
    }
    
    @objc func fullscreenButtonTouched() {
        print(playerView.frame.size)
    }
    
    @objc func switchVideo(sender: UIButton) {
        if sender.tag == 0 {
            selectNextProgram(flipping: .backward)
        } else {
            selectNextProgram(flipping: .forward)
        }
    }
    
    private func setControls() {
        controls.fullscreenButton?.addTarget(self, action: #selector(fullscreenButtonTouched), for: .touchDown)
        
        controls.rewindButton?.tag = 0
        controls.rewindButton?.addTarget(self, action: #selector(switchVideo(sender:)), for: .touchDown)
        
        controls.forwardButton?.tag = 1
        controls.forwardButton?.addTarget(self, action: #selector(switchVideo(sender:)), for: .touchDown)
    }
    
    private func updateUIForCurrentProgram() {
        guard currentProgram != nil else { return }
        programNameLabel.text = currentProgram.progname
        let startTime = Date(timeIntervalSince1970: TimeInterval(currentProgram.ut_start!))
        let endTime = Date(timeIntervalSince1970: TimeInterval(currentProgram.ut_stop!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let startTimeString = dateFormatter.string(from: startTime)
        let endTimeString = dateFormatter.string(from: endTime)
        startTimeLabel.text = startTimeString
        endTimeLabel.text = endTimeString
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let weekday = Calendar.current.component(.weekday, from: startTime)
        dateLabel.text = dateFormatter.string(from: startTime)
        switch weekday {
        case 1:
            weekDayLabel.text = NSLocalizedString("sunday", comment: "")
        case 2:
            weekDayLabel.text = NSLocalizedString("monday", comment: "")
        case 3:
            weekDayLabel.text = NSLocalizedString("tuesday", comment: "")
        case 4:
            weekDayLabel.text = NSLocalizedString("wednesday", comment: "")
        case 5:
            weekDayLabel.text = NSLocalizedString("thursday", comment: "")
        case 6:
            weekDayLabel.text = NSLocalizedString("friday", comment: "")
        case 7:
            weekDayLabel.text = NSLocalizedString("saturday", comment: "")
        default:
            break
        }
    }
    
    /// This function is responsible for selecting the next program to show. If the flipping direction is not passed as a parameter, then it selects the program that is currently broadcasted, based on local time. The "forSameDay" parameter controls the flipping direction parameter's behavior. By default it's true, so the flipping is happening between programs, but you may set it to false if you want to change calendar days instead.
    /// - Parameters:
    ///   - direction: This is an enum, which only has two cases: .forward and .backward.
    ///   - forSameDay: A boolean value, indicating whether the next program's date is the same as the currently chosen program's date.
    private func selectNextProgram(flipping direction: Direction? = nil, forSameDay: Bool = true) {
        guard programs != nil else { return }
        guard let channel = currentChannel else { return }
        
        if currentProgram == nil {
            let timestamp = NSDate().timeIntervalSince1970
            let timestampIntValue = Int(timestamp)
            for (index, program) in programs.enumerated() {
                if timestampIntValue >= program.ut_start! && timestampIntValue <= program.ut_stop! {
                    let myIndexPath = NSIndexPath(row: index, section: 0)
                    tableView.selectRow(at: myIndexPath as IndexPath, animated: true, scrollPosition: .middle)
                    currentProgram = program
                }
            }
        } else {
            switch (direction, forSameDay) {
            case (.backward, true):
                if let index = (programs.firstIndex { program -> Bool in program.ut_stop! == currentProgram.ut_start! }) {
                    let myIndexPath = NSIndexPath(row: index, section: 0)
                    tableView.selectRow(at: myIndexPath as IndexPath, animated: true, scrollPosition: .middle)
                    currentProgram = programs[index]
                }
            case (.backward, false):
                value -= 1
                if let newDate = Calendar.current.date(byAdding: .day, value: value, to: Date()) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "ddMMyy"
                    webClient.requestPrograms(forChannel: channel.id!, date: dateFormatter.string(from: newDate)) { [weak self] programsList in
                        guard let self = self else { return }
                        self.programs = programsList.epg
                        if let firstProgram = self.programs.first {
                            self.currentProgram = firstProgram
                        }
                        let myIndexPath = NSIndexPath(row: 0, section: 0)
                        self.tableView.selectRow(at: myIndexPath as IndexPath, animated: true, scrollPosition: .middle)
                    }
                }
            case (.forward, true):
                if let index = (programs.firstIndex { program -> Bool in program.ut_start! == currentProgram.ut_stop! }) {
                    let myIndexPath = NSIndexPath(row: index, section: 0)
                    tableView.selectRow(at: myIndexPath as IndexPath, animated: true, scrollPosition: .middle)
                    currentProgram = programs[index]
                }
            case (.forward, false):
                value += 1
                if let newDate = Calendar.current.date(byAdding: .day, value: value, to: Date()) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "ddMMyy"
                    webClient.requestPrograms(forChannel: channel.id!, date: dateFormatter.string(from: newDate)) { [weak self] programsList in
                        guard let self = self else { return }
                        self.programs = programsList.epg
                        if let firstProgram = self.programs.first {
                            self.currentProgram = firstProgram
                        }
                        let myIndexPath = NSIndexPath(row: 0, section: 0)
                        self.tableView.selectRow(at: myIndexPath as IndexPath, animated: true, scrollPosition: .middle)
                    }
                }
            default:
                break
            }
        }
    }
    
    private func setItemPlayerView(videoURL: String) {
        if let url = URL(string: videoURL) {
            let item = VersaPlayerItem(url: url)
            playerView.set(item: item)
        }
    }
}

extension TVPlayerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentProgram = programs[indexPath.row]
        if let cid = currentChannel.id {
            webClient.requestURL(forChannel: cid, withStartTime: String(currentProgram.ut_start!), andProtocol: "hls") { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
                self.setItemPlayerView(videoURL: self.urlString)
            }
        }
        updateUIForCurrentProgram()
    }
}

extension TVPlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard programs != nil else { return 0 }
        return programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tvProgram", for: indexPath) as? TVProgramCell {
            guard programs != nil else { return cell }
            let timestamp = NSDate().timeIntervalSince1970
            let timestampIntValue = Int(timestamp)
            if timestampIntValue < programs[indexPath.row].ut_stop! {
                cell.playButton.isHidden = true
            } else {
                cell.playButton.isHidden = false
            }
            
            cell.programTitle = programs[indexPath.row].progname
            cell.startTime = String(programs[indexPath.row].ut_start!)
            cell.endTime = String(programs[indexPath.row].ut_stop!)
            
            return cell
        }
        return UITableViewCell()
    }
}
