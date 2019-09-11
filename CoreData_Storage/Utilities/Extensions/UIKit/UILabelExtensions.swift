//
//
//
//  Created by Self on 11/16/17.
//  Copyright © 2017   All rights reserved.
//


import Foundation
import UIKit

// MARK: - Methods
public extension UILabel {
    
    
    
    /// Required height for a label
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    /// Initialize a UILabel with text
    public convenience init(text: String?) {
        self.init()
        self.text = text
    }
}
