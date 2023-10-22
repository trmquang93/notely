//
//  UseCaseProvider.swift
//  Platform
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation
import Domain

final public class UseCaseProvider {
}

public extension UseCaseProvider {
    static var notes: Domain.NTNotesUseCase {
        return NTNotesUseCase()
    }
}
