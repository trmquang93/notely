// 
//  NTToastNavigator.swift
//  Notely
//
//  Created by Quang Tran on 23/10/2023.
//

import UIKit
import VIPArchitechture
import RxSwift

protocol NTToastNavigatorType: PopOver, RequiresInput
where NavigatorInput == NTToastInput {
}

protocol NTMakeToast {
    func makeToast() -> any NTToastNavigatorType
}

extension NTMakeToast {
    func makeToast() -> any NTToastNavigatorType {
        return NTToastNavigator()
    }
}

struct NTToastInput {
    let message: Observable<String>
}

struct NTToastNavigator: NTToastNavigatorType {
    let input: ReplaySubject<NTToastInput> = .create(bufferSize: 1)
    
    func present(from presentingViewController: UIViewController) {
        Observable.just(())
            .withLatestFrom(input.flatMap { $0.message })
            .subscribe(onNext: { [weak presentingViewController] message in
                presentingViewController?.showToast(message: message, seconds: 0.3)
            })
            .disposed(by: presentingViewController.rx.disposeBag)
    }
}
