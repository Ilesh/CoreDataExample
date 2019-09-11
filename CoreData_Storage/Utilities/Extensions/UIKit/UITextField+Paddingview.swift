//
//
//
//  Created by SAS 
///

import Foundation
import UIKit

extension UITextField {
    
    func addRightView(img:UIImage,selected:UIImage){
        if let rightButton = self.rightView, rightButton is UIButton {
            print("Button exist")
            return
        }
        let button = UIButton(type: .custom)
        button.setImage(img, for: .normal)
        button.setImage(selected, for: .selected)
        //button.backgroundColor = UIColor.red
        //button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - self.height), y: CGFloat(5), width: self.height, height: self.height)
        button.removeTarget(self, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(secureMode(_:)), for: .touchUpInside)
        self.rightView = button
        self.rightView?.bringSubviewToFront(self)
        self.rightViewMode = .always
    }
    
    @objc func secureMode(_ sender: UIButton) {
        print("textfield right button")
        DispatchQueue.main.async {
            if sender.isSelected {
                sender.isSelected = false
                self.isSecureTextEntry = true
            }else{
                sender.isSelected = true
                self.isSecureTextEntry = false
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    /**
     @brief This is normal padding methods
     @param no need paramer (it's contain default parameter )
     * UITextField = textfield which you want to set left padding
     * padding = 0.5
     `````
     txtEmail.paddingview(txtEmail)
     `````
     @remark This is super easy methods
     
     */
    func paddingview(_ txtfield:UITextField)-> UITextField{
        let l3 = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: txtfield.frame.height))
        txtfield.leftView = l3
        txtfield.leftViewMode = UITextField.ViewMode.always
        return txtfield
    }
    
    /**
     @brief This is large padding methods
     @param no need paramer (it's contain default parameter )
     * UITextField = textfield which you want to set left padding
     * padding = 40
     `````
     txtEmail.paddingviewLarge(txtEmail)
     `````
     @remark This is super easy methods
     
     */
    func paddingviewLarge(_ txtfield:UITextField)-> UITextField{
        let l3 = UIView(frame: CGRect(x: 0, y: 0,width: 40, height: txtfield.frame.height))
        txtfield.leftView = l3
        txtfield.leftViewMode = UITextField.ViewMode.always
        return txtfield
    }
    func paddingviewRight(_ txtfield:UITextField)-> UITextField{
        let l3 = UIView(frame: CGRect(x: 0, y: 0,width: 40, height: txtfield.frame.height))
        txtfield.rightView = l3
        txtfield.rightViewMode = UITextField.ViewMode.always
        return txtfield
    }
    func paddingviewMedium(_ txtfield:UITextField)-> UITextField{
        let l3 = UIView(frame: CGRect(x: 0, y: 0,width: 20, height: txtfield.frame.height))
        txtfield.leftView = l3
        txtfield.leftViewMode = UITextField.ViewMode.always
        return txtfield
    }
    func paddingviewWithCustomValue(_ value:CGFloat,txtfield:UITextField){
        let l3 = UIView(frame: CGRect(x: 0, y: 0,width: value, height: txtfield.frame.height))
        txtfield.leftView = l3
        txtfield.leftViewMode = UITextField.ViewMode.always
    }
    func paddingviewRightWithCustomValue(_ value:CGFloat,txtfield:UITextField){
        let l3 = UIView(frame: CGRect(x: 0, y: 0,width: value, height: txtfield.frame.height))
        txtfield.rightView = l3
        txtfield.rightViewMode = UITextField.ViewMode.always
    }
    func DrawTextUnderline(_ lineHeight:CGFloat, lineColor:UIColor, lineWidth: CGFloat) {
        let border = CALayer()
        border.borderColor = lineColor.cgColor
        border.frame = CGRect(x: CGFloat(0), y: CGFloat(self.frame.size.height - lineHeight), width: CGFloat(lineWidth), height: CGFloat(lineHeight))
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func DrawTextTopline(_ lineHeight:CGFloat, lineColor:UIColor, lineWidth: CGFloat) {
        let border = CALayer()
        border.borderColor = lineColor.cgColor
        border.frame = CGRect(x: CGFloat(0), y:CGFloat(0), width: CGFloat(lineWidth), height: CGFloat(lineHeight))
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    /*@IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }*/
    
    @IBInspectable var placeHolderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [NSAttributedString.Key.foregroundColor : newValue]
            
            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
        }
    }
}

extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
            
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
