// 
//  NTRandomBackgroundNavigator.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
import VIPArchitechture
import RxSwift

protocol NTRandomBackgroundNavigatorType: NavigatorType, HasOutput
where NavigatorOutput == NTRandomBackgroundOutput {
}

protocol NTMakeRandomBackground {
    func makeRandomBackground() -> any NTRandomBackgroundNavigatorType
}

extension NTMakeRandomBackground {
    func makeRandomBackground() -> any NTRandomBackgroundNavigatorType {
        return NTRandomBackgroundNavigator()
    }
}

struct NTRandomBackgroundOutput {
    let isDarkBadkground: Observable<Bool>
}

struct NTRandomBackgroundNavigator: NTRandomBackgroundNavigatorType {
    let output: ReplaySubject<NTRandomBackgroundOutput> = .create(bufferSize: 1)
    
    func makeViewController() -> UIViewController {
        let viewModel = NTRandomBackgroundViewModel(navigator: self)
        let viewController = NTRandomBackgroundViewController(viewModel: viewModel)
        return viewController
    }
}
