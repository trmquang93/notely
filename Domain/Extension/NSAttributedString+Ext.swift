//
//  NSAttributedString+Ext.swift
//  Domain
//
//  Created by Quang Tran on 23/10/2023.
//

import Foundation

public extension NSAttributedString {
    
    convenience init(data: Data, documentType: DocumentType, encoding: String.Encoding = .utf8) throws {
        try self.init(
            data: data,
            options: [.documentType: documentType, .characterEncoding: encoding.rawValue],
            documentAttributes: nil)
    }
    
    func data(_ documentType: DocumentType) throws -> Data {
        // Discussion
        // Raises an rangeException if any part of range lies beyond the end of the receiver’s characters.
        // Therefore passing a valid range allow us to force unwrap the result
        try data(from: .init(location: 0, length: length),
                 documentAttributes: [.documentType: documentType])
    }
}
