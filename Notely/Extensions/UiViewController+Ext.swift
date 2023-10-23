//
//  UiViewController+Ext.swift
//  Notely
//
//  Created by Quang Tran on 22/10/2023.
//

import VIPArchitechture
import MBProgressHUD
import UIKit
import RxSwift
import RxCocoa
import Platform

public enum AppState: Equatable {
    case active
    case inactive
    case background
    case terminated
}

public extension Reactive where Base: UIViewController {
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            viewController.showAlert(message: error.localizedDescription)
        }
    }
    
    var popView: Binder<Void> {
        return Binder(base) { viewController, _ in
            guard let navigation = viewController.navigationController
            else { return }
            navigation.popViewController(animated: true)
        }
    }
    
    var dismiss: Binder<Void> {
        return Binder(base) { viewController, _ in
            viewController.dismiss(animated: true)
        }
    }
    
    var isLoading: Binder<Bool> {
        return Binder(base) { viewController, isLoading in
            let view: UIView = viewController.view
            viewController.showLoading(forView: view, isLoading: isLoading)
        }
    }
    
    var applicationDidBecomeActive: Observable<Void> {
        return NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .map { _ in return }
    }
    
    var applicationDidEnterBackground: Observable<Void> {
        return NotificationCenter.default.rx
            .notification(UIApplication.didEnterBackgroundNotification)
            .map { _ in  return }
    }
    
    var pushable: Binder<Pushable> {
        return Binder(base) { viewController, pushable in
            guard let navigation = viewController.navigationController
            else { return }
            pushable.push(to: navigation)
        }
    }
    
    var pushableViewController: Binder<UIViewController> {
        return Binder(base) { viewController, pushable in
            guard let navigation = viewController.navigationController
            else { return }
            navigation.pushViewController(pushable, animated: true)
        }
    }
    
    var popOver: Binder<PopOver> {
        return Binder(base) { viewController, popOver in
            popOver.present(from: viewController)
        }
    }
    
    var popViewController: Binder<Void> {
        return Binder(base) { viewController, _ in
            guard let navigation = viewController.navigationController
            else { return }
            navigation.popViewController(animated: true)
        }
    }
    
    var popToRootViewController: Binder<Void> {
        return Binder(base) { viewController, _ in
            guard let navigation = viewController.navigationController
            else { return }
            navigation.popToRootViewController(animated: true)
        }
    }
}

public extension Reactive where Base: UIViewController {
    var viewOneTimeAppearTrigger: Driver<Void> {
        return sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .take(1)
            .mapToVoid()
            .asDriverOnErrorJustComplete()
    }
    
    var didLayoutSubviews: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLayoutSubviews))
            .mapToVoid()
    }
    
    var viewHasSize: Driver<Void> {
        return didLayoutSubviews
            .startWith(())
            .observe(on: MainScheduler.instance)
            .filter { [weak base] in
                guard let base = base else { return false }
                return base.view.frame != .zero
            }
            .take(1)
            .asDriverOnErrorJustComplete()
    }
}

extension UIViewController {
    func showLoading(forView view: UIView, isLoading: Bool) {
        MBProgressHUD.hide(for: view, animated: true)
        if isLoading {
            MBProgressHUD.showAdded(to: view, animated: true)
            //                hud.bezelView.style = .solidColor
        } else {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
    func showWarning(
        title: String? = nil,
        message: String? = nil,
        titleButtonDone: String? = nil,
        titleButtonCancel: String? = nil,
        messageColor: UIColor? = nil,
        isCancel: Bool = false,
        completionOkAction: (() -> Void)? = nil,
        completionCancelActon: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title ?? "Alert",
                                          message: message,
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: titleButtonDone ?? "Ok",
                                         style: .destructive) { _ in
                completionOkAction?()
            }
            
            alert.addAction(okAction)
            
            if isCancel {
                let cancelAction = UIAlertAction(title: titleButtonCancel ?? "Cancel",
                                                 style: .cancel) { _ in
                    completionCancelActon?()
                }
                alert.addAction(cancelAction)
                
            }
            
            present(alert, animated: true, completion: nil)
        }
    
    func showAlert(message: String, titleButtonDone: String? = nil, completion: (() -> Void)? = nil) {
        showWarning(
            title: "Alert",
            message: message,
            titleButtonDone: titleButtonDone,
            completionOkAction: {
                completion?()
            })
    }
    
    func showToast(message: String,
                   seconds: Double,
                   textColor: UIColor? = nil,
                   backgroundColor: UIColor? = nil,
                   completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
            completion?()
        }
    }
}
