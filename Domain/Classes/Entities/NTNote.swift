//
//  NTNote.swift
//  Domain
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation

public protocol NTNote: Codable {
    var title: String { get }
    var body: String { get }
    var content: Data { get }
    var createDate: Date { get }
    var updateDate: Date { get }
}
