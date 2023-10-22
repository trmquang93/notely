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
        let text: Observable<NSAttributedString>
        let typingAttributes: Observable<TextAttributes>
    }
    
    func handleTypingAttributes(input: TypingAttributesInput) -> TypingAttributesOutput {
        let inputContent = navigator.input.flatMap { $0.content }
            .share(replay: 1)
        
        let titleStyle = NSMutableParagraphStyle()
        titleStyle.lineSpacing = 2
        titleStyle.firstLineHeadIndent = 2
        
        var titleAttributes: TextAttributes {
            [
                .font: UIFont.appFont(ofSize: 28),
                .foregroundColor: UIColor.AppColor.text,
                .paragraphStyle: titleStyle
            ]
        }
        
        var bodyAttributes: TextAttributes {
            [
                .font: UIFont.appFont(ofSize: 14),
                .foregroundColor: UIColor.AppColor.text
            ]
        }
        
        let startedNewLine = input.text
            .map {
                $0.string.hasSuffix("\n")
            }
            .filter { $0 }
            .mapToVoid()
        
        let calculatedText = input.text
            .map { text -> NSAttributedString in
                let mutable = NSMutableAttributedString(attributedString: text)
                let rawText = mutable.string
                if let endOfLine = rawText.range(of: "\n") {
                    let startNewLine = rawText.distance(
                        from: rawText.startIndex,
                        to: endOfLine.lowerBound)
                    let attributes = mutable.attributes(
                        at: startNewLine, effectiveRange: nil)
                    let textEnd = rawText.distance(
                        from: endOfLine.lowerBound,
                        to: rawText.endIndex)
                    mutable.addAttributes(
                        bodyAttributes,
                        range: .init(location: startNewLine, length: textEnd))
                } else {
                    let firstLineEnd = rawText.distance(
                        from: rawText.startIndex,
                        to: rawText.endIndex)
                    mutable.addAttributes(
                        titleAttributes,
                        range: .init(location: 0, length: firstLineEnd))
                }
                return mutable
            }
        
        let typingAttributes = startedNewLine
            .map { bodyAttributes }
            .startWith(titleAttributes)
        
        return .init(
            text: .merge(
                calculatedText,
                inputContent
            ),
            typingAttributes: typingAttributes)
    }
}
