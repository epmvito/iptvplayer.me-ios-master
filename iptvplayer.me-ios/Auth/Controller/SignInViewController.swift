//
//  SignInViewController.swift
//  iptvplayer.me-ios
//
//  Created by Никита on 11.08.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    private let authorizationManager = AuthorizationManager()
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        activityIndicator.color = .pacificBlue
        activityIndicator.stopAnimating()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        authorizationManager.delegate = self
    }

    override func didMove(toParent parent: UIViewController?) {
        if parent == nil {
//            UserDefaults.standard.removeObject(forKey: "providerAPI")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Open Tab Bar Controller" {
            if !loginTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
                self.activityIndicator.startAnimating()
                authorizationManager.sendAuthorizationRequest(withParameters: parametersForRequest()) { [weak self] response in
                    self?.activityIndicator.stopAnimating()
                    if response.statusCode == 200 {
                        self?.performSegue(withIdentifier: identifier, sender: self)
                    } else {
                        let alert = UIAlertController(title: NSLocalizedString("IncorrectLoginCredentials", comment: ""), message: NSLocalizedString("CheckLogin", comment: ""), preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "Okay", style: .cancel)
                        alert.addAction(okayAction)
                        self?.present(alert, animated: true)
                    }
                }
                return false
            } else {
                let alert = UIAlertController(title: NSLocalizedString("FieldsAboveIsEmpty", comment: ""), message: NSLocalizedString("EnterLoginAndPassword", comment: ""), preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .cancel)
                alert.addAction(okayAction)
                present(alert, animated: true)
                return false
            }
        } else {
            return false
        }
    }
    
    func parametersForRequest() -> [String: String] {
        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else { return [:] }
        guard let login = loginTextField.text, !login.isEmpty else { return [:] }
        guard let password = passwordTextField.text, !password.isEmpty else { return [:] }
        let device = UIDevice.current.model == "iPhone" ? "iptvplayer-ios-iphone" : "iptvplayer-ios-ipad"

        let parameters: [String: String] = ["login": login,
                                            "pass": password,
                                            "device": device,
                                            "deviceid": deviceID,
                                            "http_status_codes": "default"]
        return parameters
    }
    
    @IBAction func backToHomeScreen(_ sender: MainButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let validCharacters = "1234567890"
        let validCharacterSet = CharacterSet(charactersIn: validCharacters)
        let actualCharacterSet = CharacterSet(charactersIn: string)
        if validCharacterSet.isSuperset(of: actualCharacterSet) {
            return true
        } else {
            let alert = UIAlertController(title: NSLocalizedString("OnlyNumbersAllowed", comment: ""), message: NSLocalizedString("UseOnlyNumbers", comment: ""), preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(okayAction)
            present(alert, animated: true)
            return false
        }
    }
}

extension SignInViewController: AuthorizationManagerlDelegate {
    func sendAuthorizationRequest(withParameters: [String : String]) {
        print("Received SUCCESS!!!")
    }
}
