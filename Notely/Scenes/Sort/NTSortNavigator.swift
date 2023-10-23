// 
//  NTSortNavigator.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
import VIPArchitechture
import RxGesture
import RxSwift
import RxSwift

protocol NTSortNavigatorType: PopOver, RequiresInput, HasOutput
where NavigatorInput == NTSortInput, NavigatorOutput == NTSortOutput {
}

protocol NTMakeSort {
    func makeSort() -> any NTSortNavigatorType
}

extension NTMakeSort {
    func makeSort() -> any NTSortNavigatorType {
        return NTSortNavigator()
    }
}

struct NTSortInput {
    let sourceItem: Observable<Any>
}

struct NTSortOutput {
    let sortByEdited: Observable<Void>
    let sortByCreated: Observable<Void>
}

struct NTSortNavigator: NTSortNavigatorType {
    let input: ReplaySubject<NTSortInput> = .create(bufferSize: 1)
    let output: ReplaySubject<NTSortOutput> = .create(bufferSize: 1)
    
    func present(from presentingViewController: UIViewController) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortByCreateDateTrigger = PublishSubject<Void>()
        let sortByEditDateTrigger = PublishSubject<Void>()
        
        sheet.addAction(.init(
            title: R.string.localizable.create_date_sort(), 
            style: .default) {_ in
                sortByCreateDateTrigger.onNext(())
            }
        )
        
        sheet.addAction(.init(
            title: R.string.localizable.update_date_sort(), 
            style: .default) { _ in
                sortByEditDateTrigger.onNext(())
            }
        )
        
        sheet.addAction(.init(title: R.string.localizable.cancel_action(), style: .cancel))
        
        accept(output: .init(
            sortByEdited: sortByEditDateTrigger.asObservable(),
            sortByCreated: sortByCreateDateTrigger.asObservable()))
        
        Observable.just(())
            .withLatestFrom(input.flatMap { $0.sourceItem })
            .map { sourceItem in
                if let sourceView = sourceItem as? UIView {
                    sheet.popoverPresentationController?.sourceView = sourceView
                    sheet.popoverPresentationController?.sourceRect = sourceView.bounds
                } else if #available(iOS 16.0, *) {
                    let item = sourceItem as? UIPopoverPresentationControllerSourceItem
                    sheet.popoverPresentationController?.sourceItem = item
                } else {
                    let item = sourceItem as? UIBarButtonItem
                    sheet.popoverPresentationController?.barButtonItem = item
                }
            }
            .subscribe(onNext: {
                presentingViewController.present(sheet, animated: true)
            })
            .disposed(by: sheet.rx.disposeBag)
    }
}
