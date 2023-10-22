// 
//  NTNoteListViewModel+Items.swift
//  Notely
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation
import RxSwift
import VIPArchitechture

extension NTNoteListViewModel {
    struct ItemsInput {
        let searchText: Observable<String>
    }
    
    struct ItemsOutput {
        let items: Observable<AnyCollection<NTNoteCellViewModel>>
    }
    
    func handleItems(input: ItemsInput) -> ItemsOutput {
        let notes = useCase.getNotes()
        
        let displayItems = notes.map { notes in
            return notes.lazy.map { note in
                return NTNoteCellViewModel(
                    title: .just(note.title),
                    lastEditDate: .just(note.updateDate))
            }
        }
            .map { AnyCollection($0) }
        
        return .init(items: displayItems)
    }
}
