//
//  Extensions.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import Foundation

extension NSDate {
    var display : String {
        let date = self as Date
        return date.dateTimeString(withFormate: "dd MMM yyyy")
    }
}


extension String {
    
    //  NUMBER DISPLAY FORMATER
    var amount : String {
        if self != "" {
            if let number = Int(self) {
                return "\(number.format()!)"
            }else if let real = Double(self), real != Double.nan {
                return "\(real.rounded().format() ?? self)"
            }
        }
        return self
    }
}

extension Numeric {
    
    func format(numberStyle: NumberFormatter.Style = NumberFormatter.Style.decimal, locale: Locale = Locale.current) -> String? {
        if let num = self as? NSNumber {
            let formater = NumberFormatter()
            formater.numberStyle = numberStyle
            formater.locale = locale
            return formater.string(from: num)
        }
        return nil
    }
    
    func format(numberStyle: NumberFormatter.Style = NumberFormatter.Style.decimal, groupingSeparator: String = ".", decimalSeparator: String = ",") -> String? {
        if let num = self as? NSNumber {
            let formater = NumberFormatter()
            formater.numberStyle = numberStyle
            formater.groupingSeparator = groupingSeparator
            formater.decimalSeparator = decimalSeparator
            return formater.string(from: num)
        }
        return nil
    }
}
