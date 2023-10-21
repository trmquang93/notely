//
//  NTApplicationNavigator.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import VIPArchitechture

protocol NTApplicationNavigatorType: NavigatorType, NTMakeNoteList {
    
}

struct NTApplicationNavigator: NTApplicationNavigatorType {
    func makeViewController() -> UIViewController {
        let root = makeNoteList()
        
        return UINavigationController(rootViewController: root.makeViewController())
    }
}
