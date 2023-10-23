//
//  DateFormatter.swift
//  Notely
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation

extension DateFormatter {
    static var fullName: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:HH MMMM dd, yyyy"
        return formatter
    }
}
