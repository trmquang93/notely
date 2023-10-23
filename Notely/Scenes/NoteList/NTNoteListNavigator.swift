//
//  NTNoteListNavigator.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import VIPArchitechture
import Platform
import Domain
import RxSwift

protocol NTNoteListNavigatorType: NavigatorType, HasOutput,
                                  NTMakeNote, NTMakeToast, NTMakeSort
where NavigatorOutput == NTNoteListOutput {
}

protocol NTMakeNoteList {
    func makeNoteList() -> any NTNoteListNavigatorType
}

extension NTMakeNoteList {
    func makeNoteList() -> any NTNoteListNavigatorType {
        return NTNoteListNavigator()
    }
}

struct NTNoteListOutput {
    let selected: Observable<NavigatorType>
}

struct NTNoteListNavigator: NTNoteListNavigatorType {
    let output: ReplaySubject<NTNoteListOutput> = .create(bufferSize: 1)
    
    func makeViewController() -> UIViewController {
        let useCase = UseCaseProvider.notes
        let viewModel = NTNoteListViewModel(navigator: self, useCase: useCase)
        let viewController = NTNoteListViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
}
