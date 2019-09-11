//
//  Utility.swift
//  StructureApp
//


import Foundation
import UIKit

let CURRENT_DEVICE                              =   UIDevice.current

public class Utility {
    
    /// App's name (if applicable).
    public static var appDisplayName: String? {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String //return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    /// This will return a App Vendor UUID
    public static var appVendorUUID: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    /// App's bundle ID (if applicable).
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    
    /// StatusBar height
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// App current build number (if applicable).
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// Application icon badge current number.
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    
    /// App's current version (if applicable).
    public static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    
    public static var appVersionForFirebase: String? {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)?.replace(".", replacement: "_")
    }
    
    /// Current battery level.
    public static var batteryLevel: Float {
        return CURRENT_DEVICE.batteryLevel
    }
    
    /// Screen height.
    public static var screenHeight: CGFloat {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.height
        #elseif os(watchOS)
        return CURRENT_DEVICE.screenBounds.height
        #endif
    }
    
    /// Screen width.
    public static var screenWidth: CGFloat {
        #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.width
        #elseif os(watchOS)
        return CURRENT_DEVICE.screenBounds.width
        #endif
    }
    
    /// Current orientation of device.
    public static var deviceOrientation: UIDeviceOrientation {
        return CURRENT_DEVICE.orientation
    }
    
    /// Check if app is running in debug mode.
    public static var isInDebuggingMode: Bool {
        // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    /// Check if multitasking is supported in current device.
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }
    
    /// Current status bar network activity indicator state.
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
    
    /// Check if device is registered for remote notifications for current app (read-only).
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    /// Check if application is running on simulator (read-only).
    public static var isRunningOnSimulator: Bool {
        // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    /// Status bar visibility state.
    public static var isStatusBarHidden: Bool {
        get {
            return UIApplication.shared.isStatusBarHidden
        }
        set {
            UIApplication.shared.isStatusBarHidden = newValue
        }
    }
    
    /// Key window (read only, if applicable).
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    
    ///  Most top view controller (if applicable).
    public static var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }
    
    /// Class name of object as string.
    ///
    /// - Parameter object: Any object to find its class name.
    /// - Returns: Class name for given object.
    public static func typeName(for object: Any) -> String {
        let objectType = type(of: object.self)
        return String.init(describing: objectType)
    }
    
    
    /// Called when user takes a screenshot
    ///
    /// - Parameter action: a closure to run when user takes a screenshot
    public static func didTakeScreenShot(_ action: @escaping (_ notification: Notification) -> Void) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        _ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { notification in
            action(notification)
        }
    }
    
    /// Get current system dialCode
    /// - Returns: dialCode and country name
    //    public static func getCurrentDialCode() -> (dialCode: String, countryName: String)? {
    //
    //        //Get current country code of device and set
    //        let CallingCodes = { () -> [[String: String]] in
    //            let resourceBundle = Bundle(for: MICountryPicker.classForCoder())
    //            guard let path = resourceBundle.path(forResource: "CallingCodes", ofType: "plist") else { return[] }
    //            return NSArray(contentsOfFile: path) as! [[String: String]]
    //        }()
    //        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
    //            let countryData = CallingCodes.filter { $0["code"] == countryCode}
    //            if countryData.count > 0, let dialCode = countryData[0]["dial_code"], let countryName = countryData[0]["name"] {
    //                return (dialCode, countryName)
    //            }
    //        }
    //        return nil
    //    }
    
    //MARK:- Get image display size
    
    func getNewImageSizeFromCurrentImageSize(_ currentImageSize: CGSize, rectSize: CGSize) -> CGSize {
        
        let widthFactor = currentImageSize.width / rectSize.width
        
        let newSize: CGSize
        
        if currentImageSize.width < rectSize.width {
            newSize = currentImageSize
        }
        else {
            newSize = CGSize(width: currentImageSize.width/widthFactor, height: currentImageSize.height/widthFactor)
        }
        
        return newSize
    }
    
    //MARK:- Get Current Time like 1 sec ago, 1 min ago
    
    func getTimeComponentFomDateString(_ receivedDate: String) -> String{
        
        let calendar = Calendar.current as Calendar
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
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
}
