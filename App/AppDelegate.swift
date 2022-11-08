//
//  AppDelegate.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var startService: StartService?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        startService = StartService(window)
        return true
    }
}
