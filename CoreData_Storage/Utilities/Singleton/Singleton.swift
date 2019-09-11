//
//  Singleton.swift
//  
//
//  Created by SAS 
//  Copyright © 2017   All rights reserved.
//

import UIKit

class Singleton: NSObject {
    static let shared = Singleton()
    
    //MARK: - APP STATE:
    func isAppLaunchedFirst()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnceMode"){
            print("App already launched ")
            return false
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnceMode")
            print("App launched first time")
            return true
        }
    }

    func localToPSTT(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: dt!)
    }
    
    func PSTToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss, MM:dd:yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm:ss, MM:dd:yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: dt!)
    }
    
    // MARK: -  Skip Backup Attribute for File
    func addSkipBackupAttributeToItemAtURL(URL:NSURL) {
        assert(FileManager.default.fileExists(atPath: URL.path!))
        do {
            try URL.setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
        }
        catch let error as NSError {
            print("Error excluding \(URL.lastPathComponent!) from backup \(error)");
        }
    }
    
    // MARK: -  UserDefaults Methods
    func saveToUserDefaults (value: String, forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value , forKey: key as String)
        defaults.synchronize()
    }
    
    func saveJSONToUserDefaults (value: Any, forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value , forKey: key as String)
        defaults.synchronize()
    }
    
    func retriveFromUserDefaults (key: String) -> String? {
        let defaults = UserDefaults.standard
        if let strVal = defaults.string(forKey: key as String) {
            return strVal
        }
        else{
            return "" as String?
        }
    }
    
    // MARK: -  String RemoveNull and Trim Method
    func Numericalformat(count:Int) -> String {
        if count > 100000 {
            return String(Int(count / 1000))+"k"
        }
        else{
            return String(count)
        }
    }
    func displayFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
    // MARK: -  Get string size Method
    func getSizeFromString (str: String, stringWidth width: CGFloat, fontname font: UIFont, maxHeight mHeight: CGFloat) -> CGSize {
        let rect : CGRect = str.boundingRect(with: CGSize(width: width, height: mHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:font], context: nil)
        return rect.size
    }
    
    func getSizeFromAttributedString (str: NSAttributedString, stringWidth width: CGFloat, maxHeight mHeight: CGFloat) -> CGSize {
        let rect : CGRect = str.boundingRect(with: CGSize(width: width, height: mHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return rect.size
    }
    
    // MARK: -  Attributed String
    func setStringLineSpacing(_ strText: String, floatSpacing: CGFloat, intAlign: Int) -> NSMutableAttributedString {
        //0=center  1=left = 2=right
        let attributedString = NSMutableAttributedString(string: strText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = floatSpacing
        if intAlign == 0 {
            paragraphStyle.alignment = .center
        }
        else if intAlign == 1 {
            paragraphStyle.alignment = .left
        }
        else {
            paragraphStyle.alignment = .right
        }
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: (strText.count )))
        return attributedString
    }


    
    // MARK: -  get Directory Path
    func getDocumentDirPath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        return documentsPath
    }

    func dateFormatterDDEEE() -> DateFormatter {
        //2017-05-25 00:05:13
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, EEE"
        return dateFormatter
    }
    
    func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
        return calendar.date(from: components)!
    }
    
    func calculateAgefromDateString(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    //MARK:- Get Current Time like 1 sec ago, 1 min ago
    func getTimeComponentFomDateString(_ receivedDate: String) -> String{
        
        let calendar = Calendar.current as Calendar
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        
        let aDate = Date()
        let timeStamp = dateFormatter.string(from: aDate)
        
        let date11 = dateFormatter.date(from: receivedDate)!
        let date22 = dateFormatter.date(from: timeStamp)!
        
        
        var flags = Set<Calendar.Component>([.year])
        var components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.year! > 0 {
            var aTime = ""
            if components.year! == 1{
                aTime = "\(components.year!) year ago"
            }
            else {
                aTime = "\(components.year!) years ago"
            }
            return aTime as String
        }
        
        flags =  Set<Calendar.Component>([.month])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.month! > 0 {
            var aTime = ""
            if components.month! == 1{
                aTime = "\(components.month!) month ago"
            }
            else {
                aTime = "\(components.month!) months ago"
            }
            return aTime as String
        }
        
        flags =  Set<Calendar.Component>([.day])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.day! > 0 {
            var aTime = ""
            if components.day! == 1{
                aTime = "\(components.day!) day ago"
            }
            else {
                aTime = "\(components.day!) days ago"
            }
            return aTime as String         }
        
        flags =  Set<Calendar.Component>([.hour])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.hour! > 0 {
            var aTime = ""
            if components.hour! == 1{
                aTime = "\(components.hour!) hr ago"
            }
            else {
                aTime = "\(components.hour!) hrs ago"
            }
            return aTime as String
        }
        
        flags =  Set<Calendar.Component>([.minute])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.minute! > 0 {
            var aTime = ""
            if components.minute! == 1 {
                aTime = "\(components.minute!) min ago"
            }
            else
            {
                aTime = "\(components.minute!) mins ago"
            }
            
            return aTime
            
            // let aTime = "\(components.minute!) minutes"
            // return aTime as String as NSString
        }
        
        flags =  Set<Calendar.Component>([.second])
        components = calendar.dateComponents(flags, from: date11, to: date22)
        
        if components.second! > 0 {
            var aTime = ""
            if components.second! == 1 {
                aTime = "\(components.second!) sec ago"
            }
            else
            {
                aTime = "\(components.second!) secs ago"
            }
            
            return aTime
            
            // let aTime = "\(components.second!) seconds"
            // return aTime as String as NSString
        }
        
        let aTime = "0 sec ago"
        return aTime
    }
    
    //MARK:-  get Country JSon array
    func getCountryCodeJsonDataArray() -> NSArray {
        do {
            let countrydata: Data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "CountryCode", ofType: "json")!))
            do {
                if let arrData: NSArray = try JSONSerialization.jsonObject(with: countrydata, options: []) as? NSArray {
                    return arrData
                }
            } catch {
            }
        }
        catch {
        }
        return NSArray()
    }
    
   
    
    // convert images into base64 and keep them into string
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        let decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
    }
    
    //MARK:- NUMERICAL TO TEXT CONVERTED
    
    func GetNumericalMonthFromText(strMonth:String) -> String{
        if strMonth == "Jan" || strMonth == "jan" {
            return "1"
        }else if strMonth == "Feb" || strMonth == "feb" {
            return "2"
        }
        else if strMonth == "Mar" || strMonth == "mar" {
            return "3"
        }
        else if strMonth == "Apr" || strMonth == "apr" {
            return "4"
        }
        else if strMonth == "May" || strMonth == "may" {
            return "5"
        }
        else if strMonth == "Jun" || strMonth == "jun" {
            return "6"
        }
        else if strMonth == "Jul" || strMonth == "jul" {
            return "7"
        }
        else if strMonth == "Aug" || strMonth == "aug" {
            return "8"
        }
        else if strMonth == "Sep" || strMonth == "sep" {
            return "9"
        }
        else if strMonth == "Oct" || strMonth == "oct" {
            return "10"
        }
        else if strMonth == "Nov" || strMonth == "nov" {
            return "11"
        }
        else if strMonth == "Dec" || strMonth == "dec" {
            return "12"
        }else{
            return strMonth
        }
    }
    
    func GetTextToNumericalMonth(strMonth:String) -> String{
        if strMonth == "1" || strMonth == "jan" {
            return "Jan"
        }else if strMonth == "2" || strMonth == "feb" {
            return "Feb"
        }
        else if strMonth == "3" || strMonth == "mar" {
            return "Mar"
        }
        else if strMonth == "4" || strMonth == "apr" {
            return "Apr"
        }
        else if strMonth == "5" || strMonth == "may" {
            return "May"
        }
        else if strMonth == "6" || strMonth == "jun" {
            return "Jun"
        }
        else if strMonth == "7" || strMonth == "jul" {
            return "Jul"
        }
        else if strMonth == "8" || strMonth == "aug" {
            return "Aug"
        }
        else if strMonth == "9" || strMonth == "sep" {
            return "Sep"
        }
        else if strMonth == "10" || strMonth == "oct" {
            return "Oct"
        }
        else if strMonth == "11" || strMonth == "nov" {
            return "Nov"
        }
        else if strMonth == "12" || strMonth == "dec" {
            return "Dec"
        }else{
            return strMonth
        }
    }

    //Phone Number masking
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(XXX) XXX-XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    //Credit Card Number masking
    func creditCardNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "XXXX  XXXX  XXXX  XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    //Credit Card Number masking
    func creditCardExpDateNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "XX / XX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func formattedHRD_NumberDisplay(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(XXX) XXX-XXXX ext.XXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func format(phoneNumber sourcePhoneNumber: String) -> String? {
        // Remove any character that is not a number
        let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.count
        let hasLeadingOne = numbersOnly.hasPrefix("1")
        
        // Check for supported phone number length
        guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
            return nil
        }
        
        let hasAreaCode = (length >= 10)
        var sourceIndex = 0
        
        // Leading 1
        var leadingOne = ""
        if hasLeadingOne {
            leadingOne = "1 "
            sourceIndex += 1
        }
        
        // Area code
        var areaCode = ""
        if hasAreaCode {
            let areaCodeLength = 3
            guard let areaCodeSubstring = numbersOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
                return nil
            }
            areaCode = String(format: "(%@) ", areaCodeSubstring)
            sourceIndex += areaCodeLength
        }
        
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return nil
        }
        sourceIndex += prefixLength
        
        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return nil
        }
        
        return leadingOne + areaCode + prefix + "-" + suffix
    }
    
    func isValidSsn(_ ssn: String) -> Bool {
        let ssnRegext = "^(?!(000|666|9))\\d{3}-(?!00)\\d{2}-(?!0000)\\d{4}$"
        return ssn.range(of: ssnRegext, options: .regularExpression, range: nil, locale: nil) != nil
    }

    func setShadow(to view:UIView, shadowSize:CGFloat = 1.0) {
        //view.layer.frame = view.bounds
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: view.frame.size.width + shadowSize,
                                                   height: view.frame.size.height + shadowSize))
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0).cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowPath = shadowPath.cgPath
    }
}
extension Array where Element: Equatable {
    
    mutating func removeElement(_ element: Element) -> Element? {
        if let index = index(of: element) {
            return remove(at: index)
        }
        return nil
    }
}

extension String {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
