//
//  NTNoteListViewModel+Edit.swift
//  Notely
//
//  Created by Quang Tran on 23/10/2023.
//

import Foundation
import RxSwift
import VIPArchitechture
import Domain

extension NTNoteListViewModel {
    struct EditInput {
        let selected: Observable<Int>
    }
    
    struct EditOutput {
        let pushable: Observable<Pushable>
    }
    
    func handleEdit(input: EditInput) -> EditOutput {
        let navigator = self.navigator
        let items = useCase.getNotes()
        
        let noteSelected = input.selected
            .withLatestFrom(items) { $1.element(at: $0) }
            .compactMap { $0 }
            .share(replay: 1)
        
        let note = noteSelected
            .map { noteSelected in
                let note = navigator.makeNote()
                if let string = try? NSMutableAttributedString(
                    data: noteSelected.content,
                    documentType: .rtfd) {
                    let textRange = NSRange(location: 0, length: string.length)
                    string.addAttributes([.foregroundColor: R.color.text()!], range: textRange)
//                    string.addAttributes(range: <#T##NSRange#>)
                    note.accept(input: .init(content: .just(string)))
                }
                return note
            }
            .share(replay: 1)
        
        note.flatMap { $0.output }
            .flatMap { $0.finished }
            .withLatestFrom(noteSelected) { ($0, $1) }
            .flatMap { [weak self] string, noteSelected -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.useCase.saveNote(string, createdDate: noteSelected.createDate)
                    .catch { _ in .empty() }
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        return .init(pushable: note.map { $0 })
    }
}
