//
//  SpeedTestClient.swift
//  iptvplayer.me-ios
//
//  Created by Анатолий on 06.11.2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import UIKit

class SpeedTestClient: NSObject, URLSessionDownloadDelegate {
    
    var defaultSession: URLSession!
    var startTime: CFAbsoluteTime!
    var stopTime: CFAbsoluteTime!
    var bytesReceived: Int!
    var speedTestCompletionHandler: ((_ megabitesPerSecond: Double?, _ progress: Float?, _ time: Int?, _ error: Error?) -> ())!
    
    
    
    public func testDownloadSpeedWithTimout(timeout: TimeInterval, from urlString: String, completionHandler: @escaping (_ megabitesPerSecond: Double?, _ progress: Float?, _ time: Int?, _ error: Error?) -> ()) {
        let url = NSURL(string: urlString)!
        
        startTime = CFAbsoluteTimeGetCurrent()
        stopTime = startTime
        bytesReceived = 0
        speedTestCompletionHandler = completionHandler
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForResource = timeout
        configuration.httpShouldUsePipelining = true
    
        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        session.downloadTask(with: url as URL).resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        bytesReceived! = Int(totalBytesWritten)
        stopTime = CFAbsoluteTimeGetCurrent()
        let progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        
        let elapsed = stopTime - startTime
        let speed = (elapsed != 0 ? Double(bytesReceived) / elapsed / 1024.0 / 1024.0 : -1)
        print("speed:-\(speed)")
        speedTestCompletionHandler(speed, progress, nil, nil)

    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if (error != nil) {
        speedTestCompletionHandler(nil, nil, nil, error)
    }
    else {
        let size = Double(bytesReceived)
        let elapsed = stopTime - startTime
        let roundTime = Int(round(elapsed))
            let kspeed = (elapsed != 0 ? size / elapsed / 1024.0 / 1024.0 : -1)
        print ("size: \(size / 1024.0 / 1024.0)")
        print ("lost time \(elapsed)")
        print("The task finished successfully")
        speedTestCompletionHandler(kspeed, nil, roundTime, error)
        }
    }
}
