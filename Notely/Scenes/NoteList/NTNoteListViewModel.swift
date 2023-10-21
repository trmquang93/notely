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

class NTNoteListViewModel: HasDisposeBag {
    let navigator: NTNoteListNavigatorType

    init(navigator: NTNoteListNavigatorType) {
        self.navigator = navigator
    }
}

extension NTNoteListViewModel: ViewModelType {
    func transform(input: Input) -> Output {

        return .init()
    }
}

extension NTNoteListViewModel {
    struct Input {
        
    }
    
    struct Output {
    }
}
