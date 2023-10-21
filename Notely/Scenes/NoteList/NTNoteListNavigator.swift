// 
//  NTNoteListNavigator.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import VIPArchitechture

protocol NTNoteListNavigatorType: NavigatorType {
}

protocol NTMakeNoteList {
    func makeNoteList() -> NTNoteListNavigatorType
}

extension NTMakeNoteList {
    func makeNoteList() -> NTNoteListNavigatorType {
        return NTNoteListNavigator()
    }
}

struct NTNoteListNavigator: NTNoteListNavigatorType {
    func makeViewController() -> UIViewController {
        let viewModel = NTNoteListViewModel(navigator: self)
        let viewController = NTNoteListViewController(viewModel: viewModel)
        return viewController
    }
}
