//
//  SettingsTableViewController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 19.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var offerSpeedCheckWhenBrowsingCell: UITableViewCell!
    @IBOutlet weak var uploadVideoByWifiCell: UITableViewCell!
    @IBOutlet weak var doNotAskForSecurityCodeCell: UITableViewCell!
    @IBOutlet weak var exitFromProfileCell: UITableViewCell!
    @IBOutlet weak var speedTestTableViewCell: UITableViewCell!
    @IBOutlet weak var timeShiftCell: UITableViewCell!
    @IBOutlet weak var BitrateVideo: UITableViewCell!
    @IBOutlet weak var BitrateSDCell: UITableViewCell!
    @IBOutlet weak var TimeZone: UITableViewCell!
    @IBOutlet weak var Server: UITableViewCell!
    @IBOutlet weak var lan: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        offerSpeedCheckWhenBrowsingCell.accessoryView = switchForCell()
        uploadVideoByWifiCell.accessoryView = switchForCell()
        doNotAskForSecurityCodeCell.accessoryView = switchForCell()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pushToSpeedTest))
        let tapGestureRecognizerBitrateSD = UITapGestureRecognizer(target: self, action: #selector(pushToBitrateSD))
        let tapGestureRecognizerTimeShift = UITapGestureRecognizer(target: self, action: #selector(pushToTimeShift))
        let tapGestureRecognizerBitrateVideo = UITapGestureRecognizer(target: self, action: #selector(pushToBitrateVideo))
        let tapGestureRecognizerTimeZone = UITapGestureRecognizer(target: self, action: #selector(pushToTimeZone))
        let tapGestureRecognizerServer = UITapGestureRecognizer(target: self, action: #selector(pushToServer))
        let tapGestureRecognizerlan = UITapGestureRecognizer(target: self, action: #selector(pushTolan))
        let tapGestureRecognizerWiFi = UITapGestureRecognizer(target: self, action: #selector(pushToWiFi))

        speedTestTableViewCell.addGestureRecognizer(tapGestureRecognizer)
        exitFromProfileCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitFromProfile)))
        BitrateSDCell.addGestureRecognizer(tapGestureRecognizerBitrateSD)
        timeShiftCell.addGestureRecognizer(tapGestureRecognizerTimeShift)
        BitrateVideo.addGestureRecognizer(tapGestureRecognizerBitrateVideo)
        TimeZone.addGestureRecognizer(tapGestureRecognizerTimeZone)
        Server.addGestureRecognizer(tapGestureRecognizerServer)
        lan.addGestureRecognizer(tapGestureRecognizerlan)
        uploadVideoByWifiCell.addGestureRecognizer(tapGestureRecognizerWiFi)
    }
    
    // MARK: Methods
    
    func gestureRecognizer(withSelector selector: Selector, forCell cell: UITableViewCell) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        cell.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func pushToSpeedTest() {
        let speedTestVC = UIStoryboard(name: "SpeedTest", bundle: nil).instantiateViewController(identifier: "SpeedTestViewController")
        self.navigationController?.pushViewController(speedTestVC, animated: true)
    }
    
    @objc func pushToBitrateSD() {
        let bitrateVC = UIStoryboard(name: "BitrateView", bundle: nil).instantiateViewController(identifier: "BitrateSDViewController")
        self.navigationController?.pushViewController(bitrateVC, animated: true)
    }
    
    @objc func pushToTimeShift() {
        let bitrateVC = UIStoryboard(name: "BitrateView", bundle: nil).instantiateViewController(identifier: "TimeShiftViewController")
        self.navigationController?.pushViewController(bitrateVC, animated: true)
    }
    
    @objc func pushToBitrateVideo() {
        let bitrateVC = UIStoryboard(name: "BitrateView", bundle: nil).instantiateViewController(identifier: "BitrateVideotekaViewController")
        self.navigationController?.pushViewController(bitrateVC, animated: true)
    }
    
    @objc func pushToTimeZone() {
        let bitrateVC = UIStoryboard(name: "BitrateView", bundle: nil).instantiateViewController(identifier: "TimeZoneViewController")
        self.navigationController?.pushViewController(bitrateVC, animated: true)
    }
    
    @objc func pushToServer() {
        let bitrateVC = UIStoryboard(name: "BitrateView", bundle: nil).instantiateViewController(identifier: "ServerViewController")
        self.navigationController?.pushViewController(bitrateVC, animated: true)
    }
    
    @objc func pushTolan() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    @objc func pushToWiFi() {
            
    }
    
    
    @objc func exitFromProfile() {
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "rootVC")
        UserDefaults.standard.removeObject(forKey: "set-cookie")
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "pass")
        UserDefaults.standard.synchronize()
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(rootVC, animated: true)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    func switchForCell() -> UISwitch {
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        
        return switchView
    }

    // MARK: - Table view data source

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
