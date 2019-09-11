//
//  SRCutomTextField.swift


//  Created by SAS

//  Copyright © 2018 MAC7. All rights reserved.
//

import Foundation
import UIKit

class IPTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.font = UIFont.init(name: Theme.Font.Regular, size: Theme.Font.size.TxtSize)
        self.layer.masksToBounds = true
        
        /*if self.tag == 222{
            self.textColor = Theme.color.text
            self.backgroundColor = UIColor.clear
            self.placeHolderColor = Theme.color.textPlaceholder
            self.tintColor = Theme.color.text
        }
        else if self.tag == 223{
            self.textColor = Theme.color.textPlaceholderDark
            self.backgroundColor = Theme.color.textFieldLightBG
            self.placeHolderColor = Theme.color.textFieldBG
            self.tintColor = Theme.color.textDark
        }
        else if self.tag == 224{
            self.textColor = Theme.color.textPlaceholderDark
            self.backgroundColor = UIColor.white
            self.placeHolderColor = Theme.color.textPlaceholderDark
            self.tintColor = Theme.color.textDark
            self.leftView = UIView()
            self.leftView?.frame = CGRect(x: 5, y: 0, width: 20, height:35)
        }
        else if self.tag == 225{
            self.textColor = Theme.color.textPlaceholderDark
            self.backgroundColor = UIColor.white
            self.placeHolderColor = Theme.color.textPlaceholderDark
            self.tintColor = Theme.color.textDark
            self.leftView = UIView()
            self.leftView?.frame = CGRect(x: 5, y: 0, width: 20, height:35)
            
            self.layer.borderWidth = 1.0
            self.layer.borderColor = Theme.color.textPlaceholderDark.cgColor
        }
        else*/
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addPadding(.left(20))
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        if self.tag == 201 {
            //self.font = UIFont.init(name: Theme.Font.Regular, size: Theme.Font.size.TxtSize)
            self.textColor = Theme.color.text
            self.placeHolderColor = Theme.color.text
            self.backgroundColor = Theme.color.primaryTheme
//            self.layer.borderColor = Theme.color.primaryTheme.cgColor
//            self.layer.borderWidth = 1.0
            self.tintColor = Theme.color.text
            self.layer.cornerRadius = self.height/2
        }
        else {
            self.textColor = Theme.color.text
            self.tintColor = Theme.color.text
            self.backgroundColor = Theme.color.textFieldBG
            self.placeHolderColor = Theme.color.textPlaceholder
        }        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUpView()
    }
}
