//
//  UIFont+Fonts.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit

extension UIFont {
    static func appFont(ofSize fontSize: CGFloat = UIFont.systemFontSize) -> UIFont {
        return .systemFont(ofSize: fontSize)
    }
    
    static func boldAppFont(ofSize fontSize: CGFloat = UIFont.systemFontSize) -> UIFont {
        return .boldSystemFont(ofSize: fontSize)
    }
    
    static func semiBoldAppFont(ofSize fontSize: CGFloat = UIFont.systemFontSize) -> UIFont {
        return .systemFont(ofSize: fontSize, weight: .semibold)
    }
}
