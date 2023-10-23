//
//  NTNoteListViewModel+Items.swift
//  Notely
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation
import RxSwift
import VIPArchitechture
import Domain

extension NTNoteListViewModel {  
    struct ItemsInput {
        let searchText: Observable<String?>
        let sortOption: Observable<SortOption>
    }
    
    struct ItemsOutput {
        let items: Observable<AnyCollection<NTNoteCellViewModel>>
        let notes: Observable<AnyCollection<NTNote>>
    }
    
    func handleItems(input: ItemsInput) -> ItemsOutput {
        let useCase = self.useCase
        
        let notes = input.sortOption
            .startWith(.init(field: "createDate", ascending: false))
            .flatMapLatest { useCase.getNotes(sort: $0) }
            .share(replay: 1)
        
        let displayItems = Observable.combineLatest(input.searchText, notes)
            .map { searchText, notes in
                return notes.lazy
                    .filter { note in
                        guard let searchText = searchText,
                              !searchText.isEmpty,
                              let string = try? NSAttributedString(
                                data: note.content, documentType: .rtfd)
                        else { return true }
                        return string.string.lowercased().contains(searchText.lowercased())
                    }
                    .map { note in
                        return NTNoteCellViewModel(
                            title: .just(note.title),
                            lastEditDate: .just(note.updateDate))
                    }
            }
            .map { AnyCollection($0) }
            
        return .init(items: displayItems, 
                     notes: notes)
    }
}
