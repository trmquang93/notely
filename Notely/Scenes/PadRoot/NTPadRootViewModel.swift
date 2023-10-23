// 
//  NTPadRootViewModel.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import VIPArchitechture

class NTPadRootViewModel: HasDisposeBag {
    let navigator: NTPadRootNavigatorType

    init(navigator: NTPadRootNavigatorType) {
        self.navigator = navigator
    }
}

extension NTPadRootViewModel: ViewModelType {
    func transform(input: Input) -> Output {
        let noteList = navigator.makeNoteList()
        let note = noteList.output.flatMap { $0.selected }
        
        return .init(
            noteList: .just(noteList),
            noteDetail: note.asDriver().map { $0 })
    }
}

extension NTPadRootViewModel {
    struct Input {
    }
    
    struct Output {
        let noteList: Driver<Child>
        let noteDetail: Driver<Child>
    }
}
