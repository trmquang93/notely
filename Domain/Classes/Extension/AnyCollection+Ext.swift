//
//  AnyCollection+Ext.swift
//  Domain
//
//  Created by Quang Tran on 23/10/2023.
//

import Foundation

public extension AnyCollection {
    func element(at index: Int) -> Element? {
        return dropFirst(index).first
    }
}
