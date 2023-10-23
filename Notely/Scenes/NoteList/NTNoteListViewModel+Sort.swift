// 
//  NTNoteListViewModel+Sort.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import Foundation
import RxSwift
import VIPArchitechture
import Domain

extension NTNoteListViewModel {
    struct SortInput {
        let trigger: Observable<Void>
        let sourceItem: Observable<Any>
    }
    
    struct SortOutput {
        let popOver: Observable<PopOver>
        let sortOption: Observable<SortOption>
    }
    
    func handleSort(input: SortInput) -> SortOutput {
        let navigator = self.navigator
        
        let sort = input.trigger
            .withLatestFrom(input.sourceItem)
            .map { item in
                let sort = navigator.makeSort()
                sort.accept(input: .init(sourceItem: .just(item)))
                return sort
            }
            .share(replay: 1)
        let output = sort.flatMap { $0.output }
        
        let sortOption = Observable<SortOption>.merge(
            output.flatMap { $0.sortByCreated }
                .map { .init(field: "createDate", ascending: false) },
            output.flatMap { $0.sortByEdited }
                .map { .init(field: "updateDate", ascending: false) }
        )
            .share(replay: 1)

        return .init(popOver: sort.map { $0 }, sortOption: sortOption)
    }
}
