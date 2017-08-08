//
//  UITextFieldX.swift
//  AndreiSocial
//
//  Created by Mac on 08/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

@IBDesignable
class UITextFieldX: UITextField {


    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
