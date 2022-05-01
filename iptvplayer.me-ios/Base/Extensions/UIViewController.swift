//
//  UIViewController.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 21.10.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

extension UIViewController {
        
    func showAlertWithTitle(_ alertTitle: String?, andAlertMessage alertMessage: String? = nil) {
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithTitle(_ alertTitle: String?, andAlertMessage alertMessage: String? = nil, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: completion))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showYesNoAlertWithTitle(_ alertTitle: String?, andAlertMessage alertMessage: String? = nil, action: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: action))
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return (seconds/3600, (seconds % 3600)/60, (seconds % 3600) % 60)
    }
    
    func countWordsForVideo(items: [Entity]) -> [Int] {
        var countWords: [Int] = []
        for item in items {
            let video = item as! VideoCollectionCellModel
            let countWord = video.name.numberOfWords
            countWords.append(countWord)
        }
        let chunkArray = countWords.chunks(3)
        var newChunkArray:[[Int]] = []
        var arrayWithNumberWords: [Int] = []
        for subArray in chunkArray {
            if let max = subArray.max() {
            var newArray: [Int] = []
                for _ in subArray.enumerated() {
                newArray.append(max)
            }
                newChunkArray.append(newArray)
            }
        }
            for i in newChunkArray {
                for j in i {
                    arrayWithNumberWords.append(j)
                }
            }
        return arrayWithNumberWords
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
