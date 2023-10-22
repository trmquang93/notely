// 
//  NTNoteViewModel.swift
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

class NTNoteViewModel: HasDisposeBag {
    let navigator: any NTNoteNavigatorType

    init(navigator: any NTNoteNavigatorType) {
        self.navigator = navigator
    }
}

extension NTNoteViewModel: ViewModelType {
    func transform(input: Input) -> Output {
        let handleTypingAttributes = self.handleTypingAttributes(input: .init(
            text: input.attributedString))
        
        let text = handleTypingAttributes.text.share(replay: 1)
        
        navigator.accept(output: .init(
            finished: text
        ))
        
        return .init(
            attributedString: text.asDriver(),
            typingAttributes: handleTypingAttributes.typingAttributes.asDriver()
        )
    }
}

extension NTNoteViewModel {
    struct Input {
        let attributedString: Observable<NSAttributedString>
    }
    
    struct Output {
        let attributedString: Driver<NSAttributedString>
        let typingAttributes: Driver<TextAttributes>
    }
}
