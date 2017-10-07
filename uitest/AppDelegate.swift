//
//  AppDelegate.swift
//  uitest
//
//  Created by Barnabás Birmacher on 8/31/17.
//  Copyright © 2017 Barnabás Birmacher. All rights reserved.
//

import UIKit
import UIScreenCapture

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sc: UIScreenCapture?
    weak var timer: Timer?
    var mediaPath: URL!
    var idx = 0


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let fm = FileManager.default
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        mediaPath = docsurl.appendingPathComponent(String(format:"%1.2f", Date().timeIntervalSince1970 * 1000))
        
        do {
            try fm.createDirectory(at: mediaPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("failed to create directory")
        }
        print("Docs url: %@", docsurl)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0 / 6, target: self, selector: #selector(takeScreenshot), userInfo: nil, repeats: true)
        return true
    }
    
    func takeScreenshot()
    {
        let fileURL = mediaPath.appendingPathComponent(String(format: "bitrise_sc_%05d.jpg", idx))
        if let imageData = UIScreenCapture.takeSnapshotGetJPEG(0.7) {
            do {
                try imageData.write(to: fileURL)
                idx += 1
            } catch {
                print("write image failed")
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        timer?.invalidate()
    }


}

