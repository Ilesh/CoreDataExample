//
//
//
//  Created by Self on 11/16/17.
//  Copyright © 2017   All rights reserved.
//


import Foundation
import CoreGraphics

// MARK: - Properties
public extension Int {
    
    /// CountableRange 0..<Int.
    public var countableRange: CountableRange<Int> {
        return 0..<self
    }
    
    /// Radian value of degree input.
    public var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }
    
    /// Degree value of radian input
    public var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }
    
    /// UInt.
    public var uInt: UInt {
        return UInt(self)
    }
    
    /// Double.
    public var double: Double {
        return Double(self)
    }
    
    /// Float.
    public var float: Float {
        return Float(self)
    }
    
    /// CGFloat.
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    /// String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)
    public var kFormatted: String {
        var sign: String {
            return self >= 0 ? "" : "-"
        }
        let abs = Swift.abs(self)
        if abs == 0 {
            return "0k"
        } else if abs >= 0 && abs < 1000 {
            return "0k"
        } else if abs >= 1000 && abs < 1000000 {
            return String(format: "\(sign)%ik", abs / 1000)
        }
        return String(format: "\(sign)%ikk", abs / 100000)
    }
    
    ///Convert Int number string formatted like  1.1k, 1.2m
    public var abbreviateNumber: String {
        if self < 1000 {
            return "\(self)"
        }
        
        //less than 1 million, abbreviate to thousand
        if self < 1000000 {
            let n = Double( floor(Double(self)/100)/10)
            return "\(n)k"
        }
        
        //more than 1 million, abbreviate to millions
        
        let n = Double( floor(Double(self)/1000)/10)
        return "\(n)m"
        
    }
    
    public var numberFormat: String {
        let format = NumberFormatter()
        format.groupingSeparator = "."
        format.numberStyle = .decimal
        if let value = format.string(for: self) {
            return value
        }
        return ""
    }
}

// MARK: - Methods
public extension Int {
    
    /// Random integer between two integer values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random double between two double values.
    public static func random(between min: Int, and max: Int) -> Int {
        return random(inRange: min...max)
    }
    
    /// Random integer in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    /// - Returns: random double in the given closed range.
    public static func random(inRange range: ClosedRange<Int>) -> Int {
        let delta = UInt32(range.upperBound - range.lowerBound + 1)
        return range.lowerBound + Int(arc4random_uniform(delta))
    }
    
    /// check if given integer prime or not.
    /// Warning: Using big numbers can be computationally expensive!
    /// - Returns: true or false depending on prime-ness
    public func isPrime() -> Bool {
        guard self > 1 || self % 2 == 0 else {
            return false
        }
        // To improve speed on latter loop :)
        if self == 2 {
            return true
        }
        // Explanation: It is enough to check numbers until
        // the square root of that number. If you go up from N by one,
        // other multiplier will go 1 down to get similar result
        // (integer-wise operation) such way increases speed of operation
        let base = Int(sqrt(Double(self)) + 1)
        for i in Swift.stride(from: 3, to: base, by: 2) where self % i == 0 {
            return false
        }
        return true
    }
    
    /// Roman numeral string from integer (if applicable).
    ///
    ///        10.romanNumeral() -> "X"
    ///
    /// - Returns: The roman numeral string.
    public func romanNumeral() -> String? {
        // https://gist.github.com/kumo/a8e1cb1f4b7cff1548c7
        guard self > 0 else { // there is no roman numerals for 0 or negative numbers
            return nil
        }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        var romanValue = ""
        var startingValue = self
        
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            if div > 0 {
                for _ in 0..<div {
                    romanValue += romanChar
                }
                startingValue -= arabicValue * div
            }
        }
        return romanValue
    }
    
}

// MARK: - Initializers
public extension Int {
    
    /// Created a random integer between two integer values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    public init(randomBetween min: Int, and max: Int) {
        self = Int.random(between: min, and: max)
    }
    
    /// Create a random integer in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    public init(randomInRange range: ClosedRange<Int>) {
        self = Int.random(inRange: range)
    }
    
}

extension BinaryInteger {
    
    /// convert intger to binary with 4,8,16,... 32 bit
    ///
    ///     reference - https://stackoverflow.com/a/51882984/2910061
    /// description:-
    ///
    ///     UInt8(22).binaryDescription     // "0b00010110"
    ///     Int8(60).binaryDescription      // "0b00111100"
    ///     Int8(-60).binaryDescription     // "0b11000100"
    ///     Int16(255).binaryDescription    // "0b0000000011111111"
    ///     Int16(-255).binaryDescription   // "0b1111111100000001"
    ///     Int32(2359296).binaryDescription // "00000000001001000000000000000000"
    /// ---
    var binaryDescription: String {
        var binaryString = ""
        var internalNumber = self
        for _ in (1...self.bitWidth) {
            binaryString.insert(contentsOf: "\(internalNumber & 1)", at: binaryString.startIndex)
            internalNumber >>= 1
        }
        return binaryString
    }
}
