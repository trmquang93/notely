// 
//  NTNoteListViewModel.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import VIPArchitechture
import Domain

class NTNoteListViewModel: HasDisposeBag {
    let navigator: NTNoteListNavigatorType
    let useCase: NTNotesUseCase
    
    init(navigator: NTNoteListNavigatorType, useCase: NTNotesUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }
}

extension NTNoteListViewModel: ViewModelType {
    func transform(input: Input) -> Output {
        let handleItems = self.handleItems(input: .init(searchText: .empty()))
        let newNote = self.handleCreateNew(input: .init(trigger: input.createNewTrigger))
        
        return .init(
            items: handleItems.items.asDriver(),
            pushable: newNote.pushable.asSignal())
    }
}

extension NTNoteListViewModel {
    struct Input {
        let selected: Observable<Int>
        let createNewTrigger: Observable<Void>
    }
    
    struct Output {
        let items: Driver<AnyCollection<NTNoteCellViewModel>>
        let pushable: Signal<Pushable>
    }
}
