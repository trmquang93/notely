// 
//  NTNoteNavigator.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import VIPArchitechture
import Domain
import RxSwift

protocol NTNoteNavigatorType: NavigatorType, RequiresInput, HasOutput
where NavigatorInput == NTNoteInput, NavigatorOutput == NTNoteOutput {
}

protocol NTMakeNote {
    func makeNote() -> any NTNoteNavigatorType
}

extension NTMakeNote {
    func makeNote() -> any NTNoteNavigatorType {
        return NTNoteNavigator()
    }
}

struct NTNoteInput {
    let content: Observable<NSAttributedString>
}

struct NTNoteOutput {
    let finished: Observable<NSAttributedString>
}

struct NTNoteNavigator: NTNoteNavigatorType {
    let input: ReplaySubject<NTNoteInput> = .create(bufferSize: 1)
    let output: ReplaySubject<NTNoteOutput> = .create(bufferSize: 1)
    
    func makeViewController() -> UIViewController {
        let viewModel = NTNoteViewModel(navigator: self)
        let viewController = NTNoteViewController(viewModel: viewModel)
        return viewController
    }
}
