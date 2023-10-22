//
//  DateFormatter.swift
//  Notely
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation

extension DateFormatter {
    static var fullName: DateFormatter {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }
}
