//
//  PlaylistModeViewController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 11.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class PlaylistModeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: "M3U playlist", message: "", preferredStyle: .alert
            )
            alertController.addTextField { textField in
                textField.placeholder = NSLocalizedString("enterURL", comment: "")
            }
            let confirmAction = UIAlertAction(title: NSLocalizedString("save", comment: ""), style: .default) { [weak alertController] _ in
                guard let alertController = alertController,
                    let textField = alertController.textFields?.first else { return }
                
                print("Current url \(String(describing: textField.text))")
            }
            alertController.addAction(confirmAction)
            let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
