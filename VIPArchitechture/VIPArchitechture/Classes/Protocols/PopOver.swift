//
//  PopOver.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import UIKit

public protocol PopOver {
    func present(from presentingViewController: UIViewController)
}

public extension PopOver where Self: NavigatorType {
    func present(from presentingViewController: UIViewController) {
        let viewController = makeViewController()
        presentingViewController.present(viewController, animated: true)
    }
}
