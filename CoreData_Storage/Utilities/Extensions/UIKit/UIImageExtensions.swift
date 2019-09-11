//
//
//
//  Created by Self on 11/16/17.
//  Copyright © 2017   All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func generage(name:String) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.7676250935, blue: 0.6469665766, alpha: 1)
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        var initials = ""
        let initialsArray = name.components(separatedBy:" ")
        if let firstWord = initialsArray.first {
            if let firstLetter = firstWord.first {
                initials += String(firstLetter).capitalized
            }
        }
        if initialsArray.count > 1, let lastWord = initialsArray.last {
            if let lastLetter = lastWord.first {
                initials += String(lastLetter).capitalized
            }
        }
        nameLabel.text = initials
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    

    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in PNG format
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the PNG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    var png: Data? { return self.pngData() }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return  self.jpegData(compressionQuality: quality.rawValue)   //UIImageJPEGRepresentation(self, quality.rawValue)
    }
    
    func scaleImageToSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        return image
    }
    
}

// MARK: - Properties
public extension UIImage {
    
    /// Size in bytes of UIImage
    public var bytesSize: Int {
        return self.jpegData(compressionQuality: 1.0)?.count ?? 0 //UIImageJPEGRepresentation(self, 1)?.count ?? 0
    }
    
    /// Size in kilo bytes of UIImage
    public var kilobytesSize: Int {
        return bytesSize / 1024
    }
    
    /// UIImage with .alwaysOriginal rendering mode.
    public var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    /// UIImage with .alwaysTemplate rendering mode.
    public var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }

    func Base64() -> String {
        return  pngData()!.base64EncodedString() //(UIImagePNGRepresentation(self)?.base64EncodedString())!
    }
}

// MARK: - Methods
public extension UIImage {
    
    /// Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    public func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    /// Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    public func compressedData(quality: CGFloat = 0.5) -> Data? {
        return  self.jpegData(compressionQuality: quality) //UIImageJPEGRepresentation(self, quality)
    }
    
    /// UIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    public func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.height < size.height && rect.size.height < size.height else {
            return self
        }
        guard let image: CGImage = cgImage?.cropping(to: rect) else {
            return self
        }
        return UIImage(cgImage: image)
    }
    
    /// UIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - orientation: optional UIImage orientation (default is nil).
    /// - Returns: optional scaled UIImage (if applicable).
    public func scaled(toHeight: CGFloat, with orientation: UIImage.Orientation? = nil) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: toHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// UIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - orientation: optional UIImage orientation (default is nil).
    /// - Returns: optional scaled UIImage (if applicable).
    public func scaled(toWidth: CGFloat, with orientation: UIImage.Orientation? = nil) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: toWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// UIImage filled with color
    ///
    /// - Parameter color: color to fill image with.
    /// - Returns: UIImage filled with given color.
    public func filled(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = self.cgImage else {
            return self
        }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// UIImage tinted with color
    ///
    /// - Parameters:
    ///   - color: color to tint image with.
    ///   - blendMode: how to blend the tint
    /// - Returns: UIImage tinted with given color.
    public func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context!.clip(to: drawRect, mask: cgImage!)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
extension UIImage {
    
    var uncompressedPNGData: Data      { return self.pngData()!     }
    var highestQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 1.0)!} // UIImageJPEGRepresentation(self, 1.0)!  }
    var highQualityJPEGNSData: Data    { return self.jpegData(compressionQuality: 0.75)!} // UIImageJPEGRepresentation(self, 0.75)! }
    var mediumQualityJPEGNSData: Data  { return self.jpegData(compressionQuality: 0.50)!}// UIImageJPEGRepresentation(self, 0.5)!  }
    var lowQualityJPEGNSData: Data     { return self.jpegData(compressionQuality: 0.25)!} // UIImageJPEGRepresentation(self, 0.25)! }
    var lowestQualityJPEGNSData:Data   { return self.jpegData(compressionQuality: 0)!} // UIImageJPEGRepresentation(self, 0.0)!  }
    
    
    // Resize image to new width
    func resizeImage(_ newWidth: CGFloat) -> UIImage {
        
        let aNewWidth = min(newWidth, self.size.width)
        let scale = aNewWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: aNewWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: aNewWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    // MARK: -----------------
    // MARK: Image Resizing Factor According to Image Width And Height
    // MARK: -----------------
    
    
    func resizedImageWithinRect(rectSize: CGSize) -> CGSize {
        
        //        let widthRatio = rectSize.width/size.width
        //        let heightRatio = rectSize.height/size.height
        //        let scale = min(widthRatio, heightRatio)
        //        let imageWidth = scale*size.width
        //        let imageHeight = scale*size.height
        //        return CGSize(width: imageWidth, height: imageHeight)
        
        let widthFactor = size.width / rectSize.width
        //        let heightFactor = size.height / rectSize.height
        
        let resizeFactor = widthFactor
        //        if size.height > size.width {
        //            resizeFactor = heightFactor
        //        }
        let newSize : CGSize
        if size.width < rectSize.width {
            newSize = CGSize(width: size.width, height: size.height)
        }
        else
        {
            newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        }
        
        return newSize
        //        let resized = resizedImage(newSize: newSize)
        //        return resized
    }
    
    func compressImageToUpload() -> (image: UIImage, imageData: Data) {
        //Compress Image
        var compression: CGFloat = 1.0
        let maxCompression: CGFloat = 0.0
        let maxFileSize: Int = 100 * 1024 // Max file size 100KB
        var imageData: Data? = self.jpegData(compressionQuality:compression)! // UIImageJPEGRepresentation(self, compression)
        while (imageData?.count)! > maxFileSize && compression > maxCompression {
            compression -= 0.1
            imageData =  self.jpegData(compressionQuality: compression)! // UIImageJPEGRepresentation(self, compression)
        }
        let image : UIImage = UIImage(data: imageData!)!
        return (image, imageData!)
    }
    
}

// MARK: - Initializers
public extension UIImage {
    
    /// Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
    
}

