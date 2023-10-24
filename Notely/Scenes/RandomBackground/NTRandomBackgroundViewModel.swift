// 
//  NTRandomBackgroundViewModel.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import VIPArchitechture

class NTRandomBackgroundViewModel: HasDisposeBag {
    let navigator: any NTRandomBackgroundNavigatorType

    init(navigator: any NTRandomBackgroundNavigatorType) {
        self.navigator = navigator
    }
}

extension NTRandomBackgroundViewModel: ViewModelType {
    func transform(input: Input) -> Output {
        let background = handleImage(input: .init(size: input.viewSize))
        let imageInfo = background.image
            .share(replay: 1)
        
        let image = imageInfo.map { $0?.image }
        let isDark = imageInfo.compactMap { $0?.isDarkImage }
        
        navigator.accept(output: .init(
            isDarkBadkground: isDark))
        return .init(
            image: image.asDriver()
        )
    }
}

extension NTRandomBackgroundViewModel {
    struct Input {
        let viewSize: Observable<CGSize>
        
    }
    
    struct Output {
        let image: Driver<UIImage?>
    }
}
