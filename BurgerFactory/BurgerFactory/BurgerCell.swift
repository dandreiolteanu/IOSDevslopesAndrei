//
//  BurgerCell.swift
//  BurgerFactory
//
//  Created by Mac on 19/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class BurgerCell: UICollectionViewCell, NibLoadableView, Shakeable {

    @IBOutlet weak var burgerImage: UIImageView!
    @IBOutlet weak var burgerLabel: UILabel!
    
    var burger: Burger!

    func configureCell(burger: Burger) {
        
        self.burger = burger
        burgerImage.image = UIImage(named: burger.proteinId.rawValue)
        burgerLabel.text = burger.productName
    }
    
}
