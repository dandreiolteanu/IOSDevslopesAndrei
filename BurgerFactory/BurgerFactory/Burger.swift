//
//  Burger.swift
//  BurgerFactory
//
//  Created by Mac on 19/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

enum BurgerShell: Int {
    case Flour = 1
    case Corn = 2
}

enum BurgerProtein: String {
    case Beef = "Beef"
    case Chicken = "Chicken"
    case Brisket = "Salmon"
    case Fish = "Philly"
}

enum BurgerCondiment: Int {
    case Loaded = 1
    case Plain = 2
}

struct Burger {
    
    private var _id: Int!
    private var _productName: String!
    private var _shellId: BurgerShell!
    private var _proteinId: BurgerProtein!
    private var _condimentId: BurgerCondiment!
    
    var id: Int {
        return _id
    }
    
    var productName: String {
        return _productName
    }
    
    var shellId: BurgerShell {
        return _shellId
    }
    
    var proteinId: BurgerProtein {
        return _proteinId
    }
    
    var condimentId: BurgerCondiment {
        return _condimentId
    }
    
    init(id: Int, productName: String, shellId: Int, proteinId: Int, condimentId: Int) {
        self._id = id
        self._productName = productName
        
        // Burger Shell
        switch shellId {
        case 2:
            self._shellId = BurgerShell.Corn
        default:
            self._shellId = BurgerShell.Flour
        }
        
        // Burger Protein
        switch proteinId {
        case 2:
            self._proteinId = BurgerProtein.Chicken
        case 3:
            self._proteinId = BurgerProtein.Brisket
        case 4:
            self._proteinId = BurgerProtein.Fish
        default:
            self._proteinId = BurgerProtein.Beef
        }
        
        // Condiments
        switch condimentId {
        case 2:
            self._condimentId = BurgerCondiment.Plain
        default:
            self._condimentId = BurgerCondiment.Loaded
        }
    }
}


















