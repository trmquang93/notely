//
//  ViewControllerContainer.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import UIKit

public struct ViewControllerContainer {
    public weak var parent: UIViewController?
    public weak var view: UIView?
    
    public init(parent: UIViewController, view: UIView) {
        self.parent = parent
        self.view = view
    }
}

extension ViewControllerContainer {
    public func add(_ viewController: UIViewController?) {
        guard let parent = self.parent,
              let container = self.view
        else { return }
        parent.addChild(viewController, to: container)
    }
}
