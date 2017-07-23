//
//  CircleView.swift
//  Voices
//
//  Created by Olteanu Andrei on 23/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit


@IBDesignable
class CircleView: UIView {
    
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
