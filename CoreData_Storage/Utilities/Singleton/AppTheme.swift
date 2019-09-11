//
//  AppTheme.swift
//  FoodPonDriver
//
//  Created by macmini on 14/03/19.
//

import UIKit

class Global {
    // MARK: -  Dispatch Delay
    func delay(delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}


class Theme: NSObject {
    
    struct app{
        static let name = ""
    }
    // MARK: -  Application Colors
    struct color {
        
        static let primaryTheme = #colorLiteral(red: 0.3731592298, green: 0.7676250935, blue: 0.6469665766, alpha: 1)
        static let primaryRed = #colorLiteral(red: 0.9757377505, green: 0.4212496281, blue: 0.2769674063, alpha: 1)
        
        // LABELS AND TEXTS
        static let text = #colorLiteral(red: 0.9999058843, green: 1, blue: 0.9998729825, alpha: 1) //ffffff
        static let textPlaceholder = #colorLiteral(red: 0.9999058843, green: 1, blue: 0.9998729825, alpha: 1) //ffffff
        
        static let textDark = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //9A9A9A
        static let textPlaceholderDark = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 1) //9A9A9A
        
        // LABELS AND TEXTS
        static let btnText = #colorLiteral(red: 0.3731592298, green: 0.7676250935, blue: 0.6469665766, alpha: 1)
        static let btnBackground = #colorLiteral(red: 0.9999058843, green: 1, blue: 0.9998729825, alpha: 1)
        
        // TEXTVIEW BG
        static let textFieldBG = #colorLiteral(red: 0.08235294118, green: 0.1647058824, blue: 0.231372549, alpha: 0.5) //152a3b 50%
        static let textFieldLightBG = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //152a3b 50%
        
        static let GreenColor =  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        static let RedColor =  #colorLiteral(red: 1, green: 0.08235294118, blue: 0.09803921569, alpha: 1)
        static let BlueColor =  #colorLiteral(red: 0.2588235294, green: 0.5215686275, blue: 0.9568627451, alpha: 1)
        
        // CELL SEPARATOR COLOR
        static let lineBackground = #colorLiteral(red: 0.7456206679, green: 0.7461940646, blue: 0.7457094789, alpha: 1)
        static let lineDarkBackground = UIColor.lightGray
    }
    
}

struct Google {
    struct maps {
        static let keys = ""
        static let cordinateKey = ""
    }
    
    struct firebase {
        static let serverKey = ""
    }
    
    struct staticCordinate {
        static let latitude : Double = 23.0225
        static let longitude : Double = 72.5714
    }
}
