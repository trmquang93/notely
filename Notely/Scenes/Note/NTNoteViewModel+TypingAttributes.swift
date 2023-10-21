// 
//  NTNoteViewModel+TypingAttributes.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import Foundation
import RxSwift
import VIPArchitechture
import Domain

extension NTNoteViewModel {
    struct TypingAttributesInput {
        let text: Observable<NSAttributedString>
    }
    
    struct TypingAttributesOutput {
        let attributes: Observable<TextAttributes>
    }
    
    func handleTypingAttributes(input: TypingAttributesInput) -> TypingAttributesOutput {
        let numberOfLines = input.text
            .map { 
                $0.string
                    .filter { $0 == "\n" }
                    .count
            }
            .map { $0 + 1 }
            .startWith(1)
        
        var titleAttributes: TextAttributes {
            [
                .font: UIFont.appFont(ofSize: 28),
                .foregroundColor: UIColor.AppColor.text
            ]
        }
        
        var bodyAttributes: TextAttributes { 
            [
                .font: UIFont.appFont(ofSize: 14),
                .foregroundColor: UIColor.AppColor.text
            ]
        }
        
        let typingAttributes = numberOfLines
            .map { $0 == 1 ? titleAttributes : bodyAttributes }
        
        return .init(attributes: typingAttributes)
    }
}
