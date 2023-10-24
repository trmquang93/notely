// 
//  NTPhoneRootViewModel.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import VIPArchitechture

class NTPhoneRootViewModel: HasDisposeBag {
    let navigator: NTPhoneRootNavigatorType

    init(navigator: NTPhoneRootNavigatorType) {
        self.navigator = navigator
    }
}

extension NTPhoneRootViewModel: ViewModelType {
    func transform(input: Input) -> Output {
        let background = navigator.makeRandomBackground()
        let content = navigator.makeNoteList()
        let pushable = content.output.flatMap { $0.selected }
            .map { $0 as Pushable }
        
        return .init(
            background: .just(background),
            content: .just(content),
            pushable: pushable.asSignal())
    }
}

extension NTPhoneRootViewModel {
    struct Input {
        
    }
    
    struct Output {
        let background: Driver<Child>
        let content: Driver<Child>
        let pushable: Signal<Pushable>
    }
}
