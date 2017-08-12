//
//  ShadowRoundedUIView2.swift
//  LIT-socialMedia
//
//  Created by Olteanu Andrei on 12/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit

class ShadowRoundedUIView2: UIView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = 17
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.24
        self.layer.shadowRadius = 10
    }

}
