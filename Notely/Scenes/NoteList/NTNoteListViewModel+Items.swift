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
        let searchText: Observable<String?>
    }
    
    struct ItemsOutput {
        let items: Observable<AnyCollection<NTNoteCellViewModel>>
    }
    
    func handleItems(input: ItemsInput) -> ItemsOutput {
        let notes = useCase.getNotes()
        
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
            
        return .init(items: displayItems)
    }
}
