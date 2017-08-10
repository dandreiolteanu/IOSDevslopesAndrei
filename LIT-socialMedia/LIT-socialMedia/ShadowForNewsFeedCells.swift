//
//  ShadowForNewsFeedCells.swift
//  LIT-socialMedia
//
//  Created by Mac on 10/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit

class ShadowForNewsFeedCells: UIView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = 32
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 15
    }

}
