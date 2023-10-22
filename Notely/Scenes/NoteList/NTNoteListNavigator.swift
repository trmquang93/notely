// 
//  NTNoteListNavigator.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import VIPArchitechture
import Platform

protocol NTNoteListNavigatorType: NavigatorType, NTMakeNote {
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
        let useCase = UseCaseProvider.notes
        let viewModel = NTNoteListViewModel(navigator: self, useCase: useCase)
        let viewController = NTNoteListViewController(viewModel: viewModel)
        return viewController
    }
}
