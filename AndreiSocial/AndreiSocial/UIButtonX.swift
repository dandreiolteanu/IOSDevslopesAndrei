//
//  UIButtonX.swift
//  AndreiSocial
//
//  Created by Mac on 08/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class UIButtonX: UIButton {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
    }

}
