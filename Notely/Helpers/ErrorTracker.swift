//
//  ErrorTracker.swift
//  Notely
//
//  Created by Quang Tran on 23/10/2023.
//

import Foundation
import RxCocoa
import RxSwift

public final class ErrorTracker: SharedSequenceConvertibleType {
    public typealias SharingStrategy = DriverSharingStrategy
    
    public let _subject = PublishSubject<Error>()
    
    public func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable().do(onError: onError)
    }
    
    public func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
        return _subject.asObservable().asDriverOnErrorJustComplete()
    }
    
    public func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }
    
    public func onError(_ error: Error) {
        _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
    
    public init() {
        
    }
}

public extension ObservableConvertibleType {
    func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
}
