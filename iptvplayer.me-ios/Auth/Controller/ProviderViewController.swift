//
//  ProviderViewController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 10.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class ProviderViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkButtonAnchorToTextfieldConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkButtonAnchorToTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldCenterVerticallyConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldAnchorToTopSafeAreaConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Private properties
        
    fileprivate var dataArray = [ProviderDataModelItem]()
    private var statusProvider: Bool = false
    
    private var searchedProviders = [ProviderDataModelItem]() {
        didSet {
            if !searchedProviders.isEmpty {
                checkButtonAnchorToTableViewConstraint.priority = UILayoutPriority(999)
                checkButtonAnchorToTextfieldConstraint.priority = UILayoutPriority(1)
            } else {
                checkButtonAnchorToTableViewConstraint.priority = UILayoutPriority(1)
                checkButtonAnchorToTextfieldConstraint.priority = UILayoutPriority(999)
            }
            tableView?.reloadData()
            if let contentHeight = tableView?.contentSize.height, contentHeight < CGFloat(200) {
                tableViewHeightConstraint?.constant = contentHeight
            } else {
                tableViewHeightConstraint?.constant = 200
            }
            
            view.layoutIfNeeded()
        }
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.stopAnimating()
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.isHidden = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        loadData()
    }
    
    // MARK: Methods
    
    func updateLayoutIfNeededWithAnimation() {
           UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
               self.view.layoutIfNeeded()
           }, completion: nil)
       }
    
    
    // MARK: Actions
    
    @IBAction func textFieldEditingChangedAction(_ sender: UITextField) {
        if let text = sender.text, text.count >= 3 {
            searchedProviders = dataArray.filter {
                $0.name.lowercased().prefix(text.count) == text.lowercased()
            }
        } else {
            searchedProviders = []
        }
    }
    
    @IBAction func textFieldEditingDidBeginAction(_ sender: Any) {
        textFieldCenterVerticallyConstraint.priority = UILayoutPriority(1)
        textFieldAnchorToTopSafeAreaConstraint.priority = UILayoutPriority(999)
        updateLayoutIfNeededWithAnimation()
    }
    
    @IBAction func textFieldEditingDidEndAction(_ sender: Any) {
        textFieldCenterVerticallyConstraint.priority = UILayoutPriority(999)
        textFieldAnchorToTopSafeAreaConstraint.priority = UILayoutPriority(1)
        updateLayoutIfNeededWithAnimation()
    }

    @IBAction func checkButtonAction(_ sender: UIButton) {
        dismissKeyboard()
        guard let text = textField?.text, !text.isEmpty else {
            showAlertWithTitle(NSLocalizedString("LinkCantBeEmpty", comment: ""))
            return
        }
        let provider = dataArray.first(where: { $0.name == text})
        if provider == nil {
            guard let urlString = textField.text, urlString.prefix(4) == "http" else {
                showAlertWithTitle(NSLocalizedString("InvalidUrl", comment: ""))
                return
            }
            UserDefaults.standard.set(urlString, forKey: "providerAPI")
            UserDefaults.standard.synchronize()
        }
        for item in dataArray {
            if item.name == textField.text {
                UserDefaults.standard.set(item.api, forKey: "providerAPI")
                UserDefaults.standard.synchronize()
            }
        }
        checkProvider()
    }
}

// MARK: Extension for UITableViewDelegate

extension ProviderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if textField?.text != nil {
            textField?.text = searchedProviders[indexPath.row].name
            searchedProviders = []
        }
    }
}

 // MARK: Extension for UITableViewDataSource

extension ProviderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedProviders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "providerHint", for: indexPath) as? ProviderHintCell {
            cell.providerHintText = searchedProviders[indexPath.row].name
            
            return cell
        }
        return UITableViewCell()
    }
}


// MARK: Extensions for data loading

extension ProviderViewController {
    func loadData() {
        self.activityIndicator.startAnimating()
        let service = GetProvidersServiceImpl()
        service.getProviders { [weak self] (response, error) in
            if let `self` = self {
                self.activityIndicator.stopAnimating()
                if let error = error {
                    self.showAlertWithTitle(error.errorDescription)
                } else {
                    if let providers = response {
                        self.dataArray = providers
                    }
                }
            }
        }
    }
    
    func checkProvider() {
        
        self.activityIndicator.startAnimating()
        let service = GetProvidersServiceImpl()
        service.checkProvider() { [weak self] (response, error) in
            if let `self` = self {
                self.activityIndicator.stopAnimating()
                if error != nil {
                    UserDefaults.standard.removeObject(forKey: "providerAPI")
                    self.showAlertWithTitle(NSLocalizedString("InvalidUrl", comment: ""))
                } else {
                    if response != nil {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "signInVC")
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
}
