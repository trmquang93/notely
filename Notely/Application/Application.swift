//
//  Application.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit

final class NTApplication {
    static let shared = NTApplication()
    
    private init () {
    }
    
    func configMainInterface(in window: UIWindow, launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        let navigator = NTApplicationNavigator()
        let viewController = navigator.makeViewController()
        window.rootViewController = viewController
    }
}
