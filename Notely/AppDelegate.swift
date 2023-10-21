//
//  AppDelegate.swift
//  Notely
//
//  Created by Quang Tran on 18/10/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = self.window ?? UIWindow()
        self.window = window
        
        NTApplication.shared.configMainInterface(in: window)
        
        window.makeKeyAndVisible()
        return true
    }
}
