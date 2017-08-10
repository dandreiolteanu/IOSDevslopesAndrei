//
//  NewsFeedCellView.swift
//  LIT-socialMedia
//
//  Created by Mac on 10/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit

@IBDesignable
class NewsFeedCellView: UIView {


    
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
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.50
    }
}
