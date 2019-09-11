//
//
//
//  Created by Self on 11/16/17.
//  Copyright © 2017   All rights reserved.
//

import UIKit

extension UIColor {
    
    func changeImageColor(theImageView: UIImageView, newColor: UIColor) {
        theImageView.image = theImageView.image?.withRenderingMode(.alwaysOriginal)
        theImageView.tintColor = newColor;
    }
    
    convenience init(rgb: Int, alpha: CGFloat) {
        let r = CGFloat((rgb & 0xFF0000) >> 16)/255
        let g = CGFloat((rgb & 0xFF00) >> 8)/255
        let b = CGFloat(rgb & 0xFF)/255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(rgb:netHex, alpha:1.0)
    }
    
    
    public class func hexString(_ hex: String, alpha: Float = 1.0) -> UIColor {
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
        
    }
    
    public struct FlatUI {
        // http://flatuicolors.com.
        
        /// Flat UI color hex #1ABC9C
        public static let turquoise                     = UIColor.hexString("1ABC9C")
        
        /// Flat UI color hex #16A085
        public static let greenSea                      = UIColor.hexString("16A085")
        
        /// Flat UI color hex #2ECC71
        public static let emerald                       = UIColor.hexString("2ECC71")
        
        /// Flat UI color hex #27AE60
        public static let nephritis                     = UIColor.hexString("27AE60")
        
        /// Flat UI color hex #3498DB
        public static let peterRiver                    = UIColor.hexString("3498DB")
        
        /// Flat UI color hex #2980B9
        public static let belizeHole                    = UIColor.hexString("2980B9")
        
        /// Flat UI color hex #9B59B6
        public static let amethyst                      = UIColor.hexString("9B59B6")
        
        /// Flat UI color hex #8E44AD
        public static let wisteria                      = UIColor.hexString("8E44AD")
        
        /// Flat UI color hex #34495E
        public static let wetAsphalt                    = UIColor.hexString("34495E")
        
        /// Flat UI color hex #2C3E50
        public static let midnightBlue                  = UIColor.hexString("2C3E50")
        
        /// Flat UI color hex #F1C40F
        public static let sunFlower                     = UIColor.hexString("F1C40F")
        
        /// Flat UI color hex #F39C12
        public static let flatOrange                    = UIColor.hexString("F39C12")
        
        /// Flat UI color hex #E67E22
        public static let carrot                        = UIColor.hexString("E67E22")
        
        /// Flat UI color hex #D35400
        public static let pumkin                        = UIColor.hexString("D35400")
        
        /// Flat UI color hex #E74C3C
        public static let alizarin                      = UIColor.hexString("E74C3C")
        
        /// Flat UI color hex #C0392B
        public static let pomegranate                   = UIColor.hexString("C0392B")
        
        /// Flat UI color hex #ECF0F1
        public static let clouds                        = UIColor.hexString("ECF0F1")
        
        /// Flat UI color hex #BDC3C7
        public static let silver                        = UIColor.hexString("BDC3C7")
        
        /// Flat UI color hex #7F8C8D
        public static let asbestos                      = UIColor.hexString("7F8C8D")
        
        /// Flat UI color hex #95A5A6
        public static let concerte                      = UIColor.hexString("95A5A6")
        
    }
}
