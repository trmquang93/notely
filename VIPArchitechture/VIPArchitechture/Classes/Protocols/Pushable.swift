//
//  Pushable.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import UIKit

public protocol Pushable {
    func push(to navigationController: UINavigationController)
}

public extension Pushable where Self: NavigatorType {
    func push(to navigationController: UINavigationController) {
        let viewController = makeViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
