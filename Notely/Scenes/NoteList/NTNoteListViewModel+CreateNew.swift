// 
//  NTNoteListViewModel+CreateNew.swift
//  Notely
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation
import RxSwift
import VIPArchitechture

extension NTNoteListViewModel {
    struct CreateNewInput {
        let trigger: Observable<Void>
    }
    
    struct CreateNewOutput {
        let pushable: Observable<Pushable>
    }
    
    func handleCreateNew(input: CreateNewInput) -> CreateNewOutput {
        let navigator = self.navigator
        
        let newNote = input.trigger
            .map {
                let note = navigator.makeNote()
                return note
            }
            .share(replay: 1)
        
        let newNoteDate = input.trigger
            .map { Date() }
            .share(replay: 1)
        
        newNote.flatMap { $0.output }
            .flatMap { $0.finished }
            .withLatestFrom(newNoteDate) { ($0, $1) }
            .flatMap { [weak self] string, createDate -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.useCase.saveNote(string, createdDate: createDate)
                    .catch { _ in .empty() }
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        return .init(pushable: newNote.map { $0 })
    }
}
