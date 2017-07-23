//
//  CircleButton.swift
//  Voices
//
//  Created by Mac on 20/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}

class NonHighlightingButton: UIButton {
    override var isHighlighted: Bool {
        set { }
        get { return super.isHighlighted }
    }
}
