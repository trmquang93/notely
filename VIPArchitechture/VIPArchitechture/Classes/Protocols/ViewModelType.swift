//
//  ViewModelType.swift
//  picpro
//
//  Created by Quang Tran on 16/01/2023.
//  Copyright © 2023 UnitVN. All rights reserved.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
