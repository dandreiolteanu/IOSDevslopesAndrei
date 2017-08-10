//
//  ShadowView2.swift
//  LIT-socialMedia
//
//  Created by Olteanu Andrei on 10/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit

class ShadowView2: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 33
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.50
        self.layer.shadowRadius = 12
    }

}
