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
//#if DEBUG
//        return makeRandomBackground().makeViewController()
//#else
        var root: NavigatorType
        if UIDevice.current.userInterfaceIdiom == .phone {
            root = makePhoneRoot()
        } else {
            root = makePadRoot()
        }
        
        return root.makeViewController()
//#endif
    }
}

#if DEBUG
extension NTApplicationNavigator: NTMakeRandomBackground { }
#else
#endif
