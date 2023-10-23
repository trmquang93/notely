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
        let sortOption = PublishSubject<SortOption>()
        
        let handleItems = self.handleItems(input: .init(
            searchText: input.searchText,
            sortOption: sortOption.asObservable()
        ))
        let newNote = self.handleCreateNew(input: .init(trigger: input.createNewTrigger))
        let editNote = handleEdit(input: .init(
            selected: input.selected, 
            items: handleItems.notes))
        let delete = handleDelete(input: .init(
            trigger: input.deleteItem,
            items: handleItems.notes))
        let sort = handleSort(input: .init(
            trigger: input.sortTrigger,
            sourceItem: input.sortSourceItem
        ))
        
        sort.sortOption.bind(to: sortOption)
            .disposed(by: disposeBag)
        
        let pushable = Observable.merge(
            newNote.pushable,
            editNote.pushable
        )
        
        let popOver = Observable.merge(
            delete.popOver,
            sort.popOver
        )
        return .init(
            items: handleItems.items.asDriver(),
            pushable: pushable.asSignal(), 
            popOver: popOver.asSignal(),
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
        let sortTrigger: Observable<Void>
        let sortSourceItem: Observable<Any>
    }
    
    struct Output {
        let items: Driver<AnyCollection<NTNoteCellViewModel>>
        let pushable: Signal<Pushable>
        let popOver: Signal<PopOver>
        let loading: Driver<Bool>
        let error: Signal<Error>
    }
}
