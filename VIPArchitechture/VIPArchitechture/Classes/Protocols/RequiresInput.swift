//
//  RequireInput.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol RequiresInput {
    associatedtype NavigatorInput
    
    var input: ReplaySubject<NavigatorInput> { get }
}

public extension RequiresInput {
    func accept(input: NavigatorInput) {
        self.input.onNext(input)
    }
}
