//
//  UIImageViewX.swift
//  LIT-socialMedia
//
//  Created by Mac on 09/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit

class UIImageViewX: UIImageView {

    
    override func awakeFromNib() {
        
//        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
//        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
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
