//
//  Utility.swift

//
//  Created by SAS 
//  Copyright © 2018  All rights reserved.
//

import UIKit
import Photos

class PhotosUtility: NSObject,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK:singleton sharedInstance
    static let shared = PhotosUtility()
    
    // MARK:- UIImagePicker Functionality
    
    //Camera Picker
    public typealias openCameraCallBackBlock = (_ selectedImage : UIImage?) ->Void
    public var cameraCallBackBlock :openCameraCallBackBlock?
    public var cameraController : UIViewController?
    
    public func openCameraInController(_ controller:UIViewController, position : CGRect? ,completionBlock:@escaping openCameraCallBackBlock)
    {
        cameraCallBackBlock = completionBlock
        cameraController = controller
        
        UIAlertController.showActionsheetForImagePicker(cameraController!, position: position!, aStrMessage: nil) { (index, strTitle) in
            if index == 0 {
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                    
                    UIAlertController.showAlertWithOkButton(self.cameraController!, aStrMessage: "Camera not available.", completion: nil)
                }
                else{
                    
                    let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                    if (authStatus == .authorized){
                        self.openPickerWithCamera(true)
                    }else if (authStatus == .notDetermined){
                        
                        print("Camera access not determined. Ask for permission.")
                        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                            if(granted)
                            {
                                self.openPickerWithCamera(true)
                            }
                        })
                    }else if (authStatus == .restricted){
                        
                        UIAlertController.showAlertWithOkButton(self.cameraController!, aStrMessage: "You've been restricted from using the camera on this device. Please contact the device owner so they can give you access.", completion: nil)
                        
                    }else{
                        
                        UIAlertController.showAlert(self.cameraController!, aStrMessage: "It looks like your privacy settings are preventing us from accessing your camera. Goto Setting ->Camera: turn on.", style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: { (index, strTitle) in
                            
                            if index == 0{
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                            }
                        })
                    }
                }
            }
        }
    }
    
    public func openCameraInControllerWithGallery(_ controller:UIViewController, position : CGRect? ,completionBlock:@escaping openCameraCallBackBlock)
    {
        cameraCallBackBlock = completionBlock
        cameraController = controller
        
        UIAlertController.showActionsheetForImagePickerWithGallery(cameraController!, position: position!, aStrMessage: nil) { (index, strTitle) in
            if index == 1{
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                    
                    UIAlertController.showAlertWithOkButton(self.cameraController!, aStrMessage: "Camera not available.", completion: nil)
                }
                else{
                    
                    let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                    if (authStatus == .authorized){
                        self.openPickerWithCamera(true)
                    }else if (authStatus == .notDetermined){
                        
                        print("Camera access not determined. Ask for permission.")
                        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                            if(granted)
                            {
                                self.openPickerWithCamera(true)
                            }
                        })
                    }else if (authStatus == .restricted){
                        
                        UIAlertController.showAlertWithOkButton(self.cameraController!, aStrMessage: "You've been restricted from using the camera on this device. Please contact the device owner so they can give you access.", completion: nil)
                        
                    }else{
                        
                        UIAlertController.showAlert(self.cameraController!, aStrMessage: "It looks like your privacy settings are preventing us from accessing your camera. Goto Setting ->Camera: turn on.", style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: { (index, strTitle) in
                            
                            if index == 0{
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                            }
                        })
                    }
                }
            }else if index == 0{
                
                let authorizationStatus = PHPhotoLibrary.authorizationStatus()
                
                if (authorizationStatus == .authorized) {
                    // Access has been granted.
                    self.openPickerWithCamera(false)
                }else if (authorizationStatus == .restricted) {
                    // Restricted access - normally won't happen.
                    
                    UIAlertController.showAlertWithOkButton(self.cameraController!, aStrMessage: "You've been restricted from using the photos on this device. Please contact the device owner so they can give you access.", completion: nil)
                    
                }else if (authorizationStatus == .notDetermined) {
                    
                    // Access has not been determined.
                    PHPhotoLibrary.requestAuthorization({ (status) in
                        if (status == .authorized) {
                            // Access has been granted.
                            self.openPickerWithCamera(false)
                        }else {
                            // Access has been denied.
                        }
                    })
                }else{
                    UIAlertController.showAlert(self.cameraController!, aStrMessage: "It looks like your privacy settings are preventing us from accessing your photos. Goto Setting ->Photos: turn on.", style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: { (index, strTitle) in
                        
                        if index == 0{
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                    })
                }
            }
        }
    }
    
    public func openPickerWithCamera(_ isopenCamera:Bool) {
        
        let captureImg = UIImagePickerController()
        captureImg.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if(isopenCamera){
            captureImg.sourceType = UIImagePickerController.SourceType.camera
        }else{
            captureImg.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        
        captureImg.allowsEditing = false
        cameraController?.present(captureImg, animated: true, completion: nil)
    }
    
    //MARK:- UIImagePicker Controller Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if !picker.allowsEditing {
            if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                if (cameraCallBackBlock != nil){
                    cameraCallBackBlock!(img)
                }
            }
        }
        else {
            if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                if (cameraCallBackBlock != nil){
                    cameraCallBackBlock!(img)
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        if (cameraCallBackBlock != nil){
            
            cameraCallBackBlock!(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
