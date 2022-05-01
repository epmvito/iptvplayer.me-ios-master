import Foundation
import UIKit

enum TimeShift: Int{
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
}

struct TimeSettings{
    var TimeShift: TimeShift
}

class TimeShiftViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var timeshift: TimeSettings!
    var currentChannel: RowSettings!
    private var urlString = ""
    private var value = 0
    private let webClient = WebClient<BaseResponse>()
    private var currentProgram: Program! {
        didSet {
            guard let channel = currentChannel else { return }
            if let cid = channel.timeshift{
                webClient.requestSettings(timeshift: cid, timezone: nil, bitrate: nil, bitratehd: nil, vod_bitrate: nil) { [weak self] stringURL in
                    guard let self = self else { return }
                    self.urlString = stringURL
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("timeShift", comment: "")
        timeshift = TimeSettings(TimeShift: .one)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Radio4TableViewCell", bundle: nil), forCellReuseIdentifier: "Radio4TableViewCell")
    }
    
    func reqWebClient(){
        guard let channel = currentChannel else { return }
        if let cid =  channel.timeshift{
            webClient.requestSettings(timeshift: cid, timezone: nil, bitrate: nil, bitratehd: nil, vod_bitrate: nil) { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
            }
        }
    }
    
}

extension TimeShiftViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Radio4TableViewCell") as! Radio4TableViewCell
        if indexPath.row == 0 {
            cell.setCellHeaderWith("")
            cell.setOptionTitleForm(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"])
            if timeshift.TimeShift == TimeShift.four {
                cell.setOptionSelect(true)
            }
        }
        else {
            if timeshift.TimeShift == TimeShift.one {
                cell.setOptionSelect(true)
            }
            if timeshift.TimeShift == TimeShift.two {
                cell.setOptionSelect2(true)
            }
            if timeshift.TimeShift == TimeShift.three {
                cell.setOptionSelect3(true)
            }
            if timeshift.TimeShift == TimeShift.four{
                cell.setOptionSelect4(true)
            }
            if timeshift.TimeShift == TimeShift.five {
                cell.setOptionSelect5(true)
            }
            if timeshift.TimeShift == TimeShift.six {
                cell.setOptionSelect6(true)
            }
            if timeshift.TimeShift == TimeShift.seven {
                cell.setOptionSelect7(true)
            }
            if timeshift.TimeShift == TimeShift.eight {
                cell.setOptionSelect8(true)
            }
            if timeshift.TimeShift == TimeShift.nine {
                cell.setOptionSelect9(true)
            }
            if timeshift.TimeShift == TimeShift.ten {
                cell.setOptionSelect10(true)
            }
            if timeshift.TimeShift == TimeShift.eleven {
                cell.setOptionSelect11(true)
            }
            if timeshift.TimeShift == TimeShift.twelve {
                cell.setOptionSelect12(true)
            }
            
        }
        cell.cellSelectionHandler { [weak self](optionSelected) in
            guard let self = self else {return}
            if indexPath.row == 0 {
                if optionSelected == 1 {
                    self.timeshift.TimeShift = TimeShift.one
                } else {
                    self.timeshift.TimeShift = TimeShift.two
                }
            } else{
                if optionSelected == 1 {
                    self.timeshift.TimeShift = TimeShift.three
                }else{
                    self.timeshift.TimeShift = TimeShift.four
                }
            }
        }
        cell.backgroundColor = .clear
        return cell
    }
    
}
