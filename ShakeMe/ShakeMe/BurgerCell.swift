//
//  BurgerCell.swift
//  ShakeMe
//
//  Created by Mac on 19/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class BurgerCell: UITableViewCell {

    @IBOutlet weak var burgerImage: UIImageView!
    @IBOutlet weak var burgerLabel: UILabel!
    
    var burger: Burger!
    
    func configureCell(burger: Burger) {
        self.burger = burger
        burgerImage.image = UIImage(named: "Chicken")
        burgerLabel.text = "\(burger.proteinId.rawValue) Burger"
//        burgerLabel.text = burger.productName
    }
    
}
