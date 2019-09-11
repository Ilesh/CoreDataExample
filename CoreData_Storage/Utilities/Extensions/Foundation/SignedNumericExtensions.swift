//
//
//
//  Created by Self on 11/16/17.
//  Copyright © 2017   All rights reserved.
//


import Foundation

// MARK: - Properties
public extension SignedNumeric {
    
    /// String.
    public var string: String {
        return String(describing: self)
    }
    
    /// String with number and current locale currency.
    public var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        guard let number = self as? NSNumber else { return "" }
        return formatter.string(from: number) ?? ""
    }
}
