//
//  Child.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import UIKit

public protocol Child {
    func add(to container: ViewControllerContainer)
}

public struct EmptyChild: Child, NavigatorType {
    public init() {}
    public func makeViewController() -> UIViewController {
        return UIViewController()
    }
}

public extension Child where Self: NavigatorType {
    func add(to container: ViewControllerContainer) {
        let viewController = makeViewController()
        container.add(viewController)
    }
}

public extension Child {
    func addFill(in viewController: UIViewController) {
        let container = ViewControllerContainer(parent: viewController, view: viewController.view)
        add(to: container)
    }
}
