import Foundation
import UIKit

enum Server: Int{
    case EuropeNorth = 1
    case EuropeCentral = 2
    case USANorth = 3
    case USASouth = 4
    case Israel = 5
}

struct ServerSettings{
    var Server: Server
}

class ServerViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var server: ServerSettings!
    var currentChannel: RowSettings!
    private var urlString = ""
    private var value = 0
    private let webClient = WebClient<BaseResponse>()
    private var currentProgram: Program! {
        didSet {
            guard let channel = currentChannel else { return }
            if channel.stream_server != nil{
                webClient.requestSettings(timeshift: nil, timezone: nil, bitrate: nil, bitratehd: nil, vod_bitrate: nil) { [weak self] stringURL in
                    guard let self = self else { return }
                    self.urlString = stringURL
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("server", comment: "")
        server = ServerSettings(Server: .EuropeNorth)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 190.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Radio3TableViewCell", bundle: nil), forCellReuseIdentifier: "Radio3TableViewCell")
    }
    
    func reqWebClient(){
        guard let channel = currentChannel else { return }
        if let cid =  channel.stream_server{
            webClient.requestSettings(timeshift: nil, timezone: nil, bitrate: nil, bitratehd: nil, vod_bitrate: cid) { [weak self] stringURL in
                guard let self = self else { return }
                self.urlString = stringURL
            }
        }
    }
}

extension ServerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Radio3TableViewCell") as! Radio3TableViewCell
        if indexPath.row == 0 {
            cell.setCellHeaderWith("")
            cell.setOptionTitleForm(["Europe North", "Europe Central", "USA North", "USA South", "Israel"])
            if server.Server == Server.EuropeNorth {
                cell.setOptionSelect(true)
            }
            if server.Server == Server.EuropeCentral {
                cell.setOptionSelect2(true)
            }
            if server.Server == Server.USANorth {
                cell.setOptionSelect3(true)
            }
            if server.Server == Server.USASouth {
                cell.setOptionSelect4(true)
            }
            if server.Server == Server.Israel {
                cell.setOptionSelect5(true)
            }
        }
        cell.cellSelectionHandler { [weak self](optionSelected) in
            guard let self = self else {return}
            if indexPath.row == 0 {
                if optionSelected == 1 {
                    self.server.Server = Server.EuropeNorth
                } else {
                    self.server.Server = Server.EuropeCentral
                }
            } else{
                if optionSelected == 1 {
                    self.server.Server = Server.USANorth
                }else{
                    self.server.Server = Server.Israel
                }
            }
        }
        cell.backgroundColor = .clear
        return cell
        }
    
}
