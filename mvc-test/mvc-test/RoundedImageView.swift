//
//  RoundedImageView.swift
//  mvc-test
//
//  Created by Mac on 07/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit



//Making an UIImageView have rounded corners

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
    }

}
