//
//  NTApplicationNavigator.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import VIPArchitechture

protocol NTApplicationNavigatorType: NavigatorType, NTMakeNote {
    
}

struct NTApplicationNavigator: NTApplicationNavigatorType {
    func makeViewController() -> UIViewController {
        let root = makeNote()
        
        return UINavigationController(rootViewController: root.makeViewController())
    }
}
