//
//  NTApplicationNavigator.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import VIPArchitechture

protocol NTApplicationNavigatorType: NavigatorType, NTMakePhoneRoot, NTMakePadRoot {
    
}

struct NTApplicationNavigator: NTApplicationNavigatorType {
    func makeViewController() -> UIViewController {
        var root: NavigatorType
        if UIDevice.current.userInterfaceIdiom == .phone {
            root = makePhoneRoot()
        } else {
            root = makePadRoot()
        }
        
        return root.makeViewController()
    }
}
