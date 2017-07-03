//
//  RoundedButton.swift
//  helloWorld
//
//  Created by Mac on 03/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override func draw(_ _rect: CGRect) {
        super.draw(_rect)
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        
    }
}
