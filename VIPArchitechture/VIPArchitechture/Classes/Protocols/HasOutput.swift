//
//  HasOutput.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol HasOutput {
    associatedtype NavigatorOutput
    
    var output: ReplaySubject<NavigatorOutput> { get }
}

public extension HasOutput {
    
    func accept(output: NavigatorOutput) {
        self.output.onNext(output)
    }
}
