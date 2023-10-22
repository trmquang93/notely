//
//  QueryDocumentSnapshot+Ext.swift
//  Platform
//
//  Created by Quang Tran on 22/10/2023.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
    var json: [String: Any] {
        var data = self.data().mapValues { value -> Any in
            if let date = value as? Date {
                return DateFormatter().string(from: date)
            } else if let timestamp = value as? Timestamp {
                let date = timestamp.dateValue()
                return DateFormatter().string(from: date)
            }
            return value
        }
        
        data["id"] = documentID
        return data
    }
}
