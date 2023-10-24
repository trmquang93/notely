// 
//  NTPhoneRootNavigator.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
import VIPArchitechture

protocol NTPhoneRootNavigatorType: NavigatorType, NTMakeNoteList, NTMakeRandomBackground {
}

protocol NTMakePhoneRoot {
    func makePhoneRoot() -> NTPhoneRootNavigatorType
}

extension NTMakePhoneRoot {
    func makePhoneRoot() -> NTPhoneRootNavigatorType {
        return NTPhoneRootNavigator()
    }
}

struct NTPhoneRootNavigator: NTPhoneRootNavigatorType {
    func makeViewController() -> UIViewController {
        let viewModel = NTPhoneRootViewModel(navigator: self)
        let viewController = NTPhoneRootViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
}
