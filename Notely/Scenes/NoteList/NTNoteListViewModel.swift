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
        let handleItems = self.handleItems(input: .init(searchText: input.searchText))
        let newNote = self.handleCreateNew(input: .init(trigger: input.createNewTrigger))
        let editNote = handleEdit(input: .init(
            selected: input.selected))
        let delete = handleDelete(input: .init(trigger: input.deleteItem))
        
        let pushable = Observable.merge(
            newNote.pushable,
            editNote.pushable
        )
        return .init(
            items: handleItems.items.asDriver(),
            pushable: pushable.asSignal(), 
            popOver: delete.popOver.asSignal(),
            loading: delete.loading.asDriver(),
            error: delete.error.asSignal()
        )
    }
}

extension NTNoteListViewModel {
    struct Input {
        let selected: Observable<Int>
        let createNewTrigger: Observable<Void>
        let searchText: Observable<String?>
        let deleteItem: Observable<Int>
    }
    
    struct Output {
        let items: Driver<AnyCollection<NTNoteCellViewModel>>
        let pushable: Signal<Pushable>
        let popOver: Signal<PopOver>
        let loading: Driver<Bool>
        let error: Signal<Error>
    }
}
