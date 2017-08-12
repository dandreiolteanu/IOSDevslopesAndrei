//
//  ShadowRoundedUIView.swift
//  LIT-socialMedia
//
//  Created by Olteanu Andrei on 10/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit

class ShadowRoundedUIView: UIView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.frame.height / 2 
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 12
    }

}
