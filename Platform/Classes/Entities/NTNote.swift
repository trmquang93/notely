//
//  NTNote.swift
//  Platform
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation
import Domain

struct NTNote: Domain.NTNote, Codable {
    var title: String
    
    var body: String
    
    var content: Data
    
    var createDate: Date
    
    var updateDate: Date
}
