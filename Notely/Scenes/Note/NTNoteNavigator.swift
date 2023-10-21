// 
//  NTNoteNavigator.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import VIPArchitechture

protocol NTNoteNavigatorType: NavigatorType {
}

protocol NTMakeNote {
    func makeNote() -> NTNoteNavigatorType
}

extension NTMakeNote {
    func makeNote() -> NTNoteNavigatorType {
        return NTNoteNavigator()
    }
}

struct NTNoteNavigator: NTNoteNavigatorType {
    func makeViewController() -> UIViewController {
        let viewModel = NTNoteViewModel(navigator: self)
        let viewController = NTNoteViewController(viewModel: viewModel)
        return viewController
    }
}
