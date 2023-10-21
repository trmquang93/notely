//
//  ObservableType+.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    public func catchErrorJustComplete() -> Observable<Element> {
        return `catch` { _ in
            return Observable.empty()
        }
    }
    
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    public func mapToOptional() -> Observable<Element?> {
        return map { value -> Element? in value }
    }
    
    public func unwrap<T>() -> Observable<T> where Element == T? {
        return flatMap { Observable.from(optional: $0) }
    }
}

extension SharedSequenceConvertibleType {
    
    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
    
    public func mapToOptional() -> SharedSequence<SharingStrategy, Element?> {
        return map { value -> Element? in value }
    }
    
    public func unwrap<T>() -> SharedSequence<SharingStrategy, T> where Element == T? {
        return flatMap { SharedSequence.from(optional: $0) }
    }
}

extension ObservableConvertibleType {
    public func asSignalOnErrorJustSkip() -> Signal<Element> {
        return self.asSignal(onErrorSignalWith: .empty())
    }
    
    public func asDriver() -> Driver<Element> {
        return self.asDriver(onErrorDriveWith: .empty())
    }
    
    public func asSignal() -> Signal<Element> {
        return asSignalOnErrorJustSkip()
    }
}

extension BehaviorRelay {
    var mutableValue: Element {
        get {
            return value
        }
        set {
            accept(newValue)
        }
    }
}
