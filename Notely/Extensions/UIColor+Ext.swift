//
//  UIColor+Ext.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit

extension UIColor {
    struct AppColor {
        
    }
}

extension UIColor.AppColor {
    static var text: UIColor { R.color.text()! }
    static var accent: UIColor { R.color.accentColor()! }
    static var secondaryBackground: UIColor { R.color.secondaryBackground()! }
}
