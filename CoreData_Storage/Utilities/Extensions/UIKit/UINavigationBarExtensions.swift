//
//
//
//  Created by SAS 
//  Copyright © 2017   All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationBar {
    
    /// Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font
    ///   - color: title text color (default is .black).
    public func setTitleFont(_ font: UIFont, color: UIColor = UIColor.black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        titleTextAttributes = attrs
    }
    
    /// Make navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    public func makeTransparent(withTint tint: UIColor = .white) {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        tintColor = tint
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: tint]
    }
    
    /// Set navigationBar background and text colors
    ///
    /// - Parameters:
    ///   - background: backgound color
    ///   - text: text color
    public func setColors(background: UIColor, text: UIColor) {
        isTranslucent = false
        backgroundColor = background
        barTintColor = background
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        tintColor = text
        titleTextAttributes = [.foregroundColor: text]
    }
    
    
}
