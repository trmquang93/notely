//
//  NavigatorType.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol NavigatorType: Child, PopOver, Pushable {
    func makeViewController() -> UIViewController
}

public struct EmptyNavigator: NavigatorType {
    public init() {}
    public func makeViewController() -> UIViewController {
        return UIViewController()
    }
}

public protocol CanInit {
    init()
}

extension NavigatorType where Self: CanInit {
    func makeNavigator() -> Self {
        return Self()
    }
}
