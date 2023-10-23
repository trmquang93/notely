// 
//  NTPhoneRootNavigator.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
import VIPArchitechture

protocol NTPhoneRootNavigatorType: NavigatorType, NTMakeNoteList {
}

protocol NTMakePhoneRoot {
    func makePhoneRoot() -> NTPhoneRootNavigatorType
}

extension NTMakePhoneRoot {
    func makePhoneRoot() -> NTPhoneRootNavigatorType {
        return NTPhoneRootNavigator()
    }
}

struct NTPhoneRootNavigator: NTPhoneRootNavigatorType {
    func makeViewController() -> UIViewController {
        let noteList = makeNoteList()
        let viewController = noteList.makeViewController()
        
        noteList.output.flatMap { $0.selected }
            .map { $0 as Pushable }
            .asDriver()
            .drive(viewController.rx.pushable)
            .disposed(by: viewController.rx.disposeBag)
        
        return viewController
    }
}
