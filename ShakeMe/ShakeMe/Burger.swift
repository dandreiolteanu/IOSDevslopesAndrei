//
//  Burger.swift
//  ShakeMe
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
    case Salmon = "Salmon"
    case Philly = "Philly"
}

enum BurgerCondiment: Int {
    
    case Loaded = 1
    case Plain = 2
}

class Burger {
    
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
        
        _id = id
        _productName = productName
        
        // Burger shell
        switch shellId {
        case 2:
            self._shellId = BurgerShell.Corn
        default:
            self._shellId = BurgerShell.Flour
        }
        
        // Burger protein
        switch proteinId {
        case 2:
            self._proteinId = BurgerProtein.Chicken
        case 3:
            self._proteinId = BurgerProtein.Salmon
        case 4:
            self._proteinId = BurgerProtein.Philly
        default:
            self._proteinId = BurgerProtein.Beef
        }
        
        // Burger condiment
        switch condimentId {
        case 2:
            self._condimentId = BurgerCondiment.Plain
        default:
            self._condimentId = BurgerCondiment.Loaded
        }
        
    }
    
}
















