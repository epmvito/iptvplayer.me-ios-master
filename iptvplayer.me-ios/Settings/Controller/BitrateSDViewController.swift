import Foundation
import UIKit
import Alamofire

enum BitrateSD: Int{
    case Automatic = 1
    case Standart = 2
    case Economy = 3
}

enum BitrateHD: Int{
    case Automatic = 1
    case Standart = 2
    case Economy = 3
}

struct Bitrate{
    var BitarteSD: BitrateSD
    var BitarteHD: BitrateHD
}

var videoSettingsList:[RowSettings] = [RowSettings]()
class BitrateSDViewConroller: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bitrate: Bitrate!
    var currentChannel: RowSettings!
    private var urlString = ""
    private var value = 0
    private let webClient = WebClient<BaseResponse>()
    private var currentProgram: Program! {
        didSet {
            guard let channel = currentChannel else { return }
            if let cid = channel.bitrate{
                webClient.requestSettings(timeshift: nil, timezone: nil, bitrate: cid, bitratehd: nil, vod_bitrate: nil) { [weak self] stringURL in
                    guard let self = self else { return }
                    self.urlString = stringURL
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Bitrate", comment: "")
        
        bitrate = Bitrate(BitarteSD: BitrateSD.Automatic, BitarteHD: BitrateHD.Automatic)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 180.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RadioTableViewCell", bundle: nil), forCellReuseIdentifier: "RadioTableViewCell")
    }
    
    func reqWebClient(){
        guard let channel = currentChannel else { return }
        if let cid =  channel.bitrate{
            webClient.requestSettings(timeshift: nil, timezone: nil, bitrate: cid, bitratehd: nil, vod_bitrate: nil) { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
            }
        }
    }
}

extension BitrateSDViewConroller: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioTableViewCell") as! RadioTableViewCell
        if indexPath.row == 0 {
            cell.setCellHeaderWith("Bitrate SD")
            cell.setOptionTitleForm(["Automatic", "Standart", "Economy"])
            if bitrate.BitarteSD == BitrateSD.Economy{
                cell.setOptionSelect(true)
                cell.setOptionSelect2(true)
            }else {
                cell.setOptionSelect(false)
                cell.setOptionSelect2(false)
            }
        } else {
            cell.setCellHeaderWith("Bitrate HD")
            cell.setOptionTitleForm(["Automatic", "Standart", "Economy"])
            if bitrate.BitarteHD == BitrateHD.Standart{
                cell.setOptionSelect(true)
                cell.setOptionSelect2(true)
            }else {
                cell.setOptionSelect(false)
                cell.setOptionSelect2(false)
            }
        }
        cell.cellSelectionHandler { [weak self](optionSelected) in
            guard let self = self else {return}
            if indexPath.row == 0 {
                if optionSelected == 0 {
                    self.bitrate.BitarteSD = BitrateSD.Automatic
                } else {
                    self.bitrate.BitarteSD = BitrateSD.Standart
                }
            } else{
                if optionSelected == 1 {
                    self.bitrate.BitarteHD = BitrateHD.Automatic
                }else{
                    self.bitrate.BitarteHD = BitrateHD.Standart
                }
            }
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
