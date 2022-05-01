import Foundation
import UIKit

enum BitrateVideo: Int{
    case Automatic = 1
    case HD = 2
    case FullHD = 3
    case UltraHD4KHEVC = 4
}

struct BitrateVid{
    var BitarteVideo: BitrateVideo
}

class BitrateVideotekaViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var bitrate: BitrateVid!
    
    
    var currentChannel: RowSettings!
    private var urlString = ""
    private var value = 0
    private let webClient = WebClient<BaseResponse>()
    private var currentProgram: Program! {
        didSet {
            guard let channel = currentChannel else { return }
            if let cid = channel.vod_bitrate{
                webClient.requestSettings(timeshift: nil, timezone: nil, bitrate: nil, bitratehd: nil, vod_bitrate: cid) { [weak self] stringURL in
                    guard let self = self else { return }
                    self.urlString = stringURL
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("BitrateVideoteka", comment: "")
        bitrate = BitrateVid(BitarteVideo: BitrateVideo.Automatic)
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 190.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Radio2TableViewCell", bundle: nil), forCellReuseIdentifier: "Radio2TableViewCell")
    }
    
    func reqWebClient(){
        guard let channel = currentChannel else { return }
        if let cid =  channel.vod_bitrate{
            webClient.requestSettings(timeshift: nil, timezone: nil, bitrate: nil, bitratehd: nil, vod_bitrate: cid) { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
            }
        }
    }
}

extension BitrateVideotekaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Radio2TableViewCell") as! Radio2TableViewCell
        if indexPath.row == 0 {
            cell.setCellHeaderWith("")
            cell.setOptionTitleForm(["Standart", "HD", "FullHD", "UltraHD 4K HEVC"])
            if bitrate.BitarteVideo == BitrateVideo.Automatic{
                cell.setOptionSelect(true)
                cell.setOptionSelect2(true)
            }else {
                cell.setOptionSelect(false)
                cell.setOptionSelect2(false)
            }
        } else {
            if bitrate.BitarteVideo == BitrateVideo.FullHD{
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
                if optionSelected == 1 {
                    self.bitrate.BitarteVideo = BitrateVideo.Automatic
                } else {
                    self.bitrate.BitarteVideo = BitrateVideo.FullHD
                }
            } else{
                if optionSelected == 1 {
                    self.bitrate.BitarteVideo = BitrateVideo.HD
                }else{
                    self.bitrate.BitarteVideo = BitrateVideo.UltraHD4KHEVC
                }
            }
        }
        cell.backgroundColor = .clear
        return cell
    }
}
