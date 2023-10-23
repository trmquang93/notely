// 
//  NTNoteListViewModel+Delete.swift
//  Notely
//
//  Created by Quang Tran on 23/10/2023.
//

import Foundation
import RxSwift
import VIPArchitechture
import Domain

extension NTNoteListViewModel {
    struct DeleteInput {
        let trigger: Observable<Int>
        let items: Observable<AnyCollection<NTNote>>
    }
    
    struct DeleteOutput {
        let loading: Observable<Bool>
        let error: Observable<Error>
        let popOver: Observable<PopOver>
    }
    
    func handleDelete(input: DeleteInput) -> DeleteOutput {
        let notes = input.items
        let useCase = self.useCase
        let navigator = self.navigator
        let activityTracker = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let noteToDelete = input.trigger
            .withLatestFrom(notes) { $1.element(at: $0) }
            .compactMap { $0 }
        
        let toast = noteToDelete
            .flatMap {
                useCase.delete($0)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .catch { _ in .empty() }
            }
            .map {
                let toast = navigator.makeToast()
                toast.accept(input: .init(message: .just(R.string.localizable.success_toast())))
                
                return toast
            }
            .share(replay: 1)
        
        return .init(
            loading: activityTracker.asObservable(),
            error: errorTracker.asObservable(),
            popOver: toast.map { $0 })
    }
}
