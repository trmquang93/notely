//
//  NTNotesUseCase.swift
//  Domain
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation
import RxSwift

public protocol NTNotesUseCase {
    func getNotes() -> Observable<AnyCollection<NTNote>>
    func saveNote(_ data: NSAttributedString, createdDate: Date) -> Observable<Void>
    func delete(_ note: NTNote) -> Observable<Void>
}
