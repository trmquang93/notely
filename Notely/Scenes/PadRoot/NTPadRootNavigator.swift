// 
//  NTPadRootNavigator.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
import VIPArchitechture

protocol NTPadRootNavigatorType: NavigatorType, NTMakeNote, NTMakeNoteList {
}

protocol NTMakePadRoot {
    func makePadRoot() -> NTPadRootNavigatorType
}

extension NTMakePadRoot {
    func makePadRoot() -> NTPadRootNavigatorType {
        return NTPadRootNavigator()
    }
}

struct NTPadRootNavigator: NTPadRootNavigatorType {
    func makeViewController() -> UIViewController {
        let viewModel = NTPadRootViewModel(navigator: self)
        let viewController = NTPadRootViewController(viewModel: viewModel)
        return viewController
    }
}
