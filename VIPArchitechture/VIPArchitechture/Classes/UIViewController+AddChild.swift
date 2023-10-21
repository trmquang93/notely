//
//  UIViewController+AddChild.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import UIKit
import RxSwift


public extension UIViewController {
    @objc func addChild(_ child: UIViewController?, to view: UIView) {
        
        removeAllChildren(in: view)
        
        guard let child = child else { return }
        let childView: UIView = child.view
        child.willMove(toParent: self)
        
        view.addSubview(childView)
        addChild(child)
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: view.topAnchor),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        child.didMove(toParent: self)
    }
    
    func removeAllChildren(in view: UIView) {
        for child in children(in: view) {
            child.willMove(toParent: nil)
            child.removeFromParent()
            child.view.removeFromSuperview()
            child.didMove(toParent: nil)
        }
    }
    
    func children(in view: UIView) -> [UIViewController] {
        return children.filter({ $0.view.superview == view })
    }
}

public extension Reactive where Base: UIViewController {
    func child(in containerView: UIView) -> Binder<Child> {
        Binder(self.base) { viewController, child in
            let container = ViewControllerContainer(parent: viewController, view: containerView)
            child.add(to: container)
        }
    }
}
