//
//  DataServiced.swift
//  BurgerFactory
//
//  Created by Jack Davis on 7/25/16.
//  Copyright © 2017 Andrei Olteanu. All rights reserved.
//

import Foundation

// Delegate pattern
protocol DataServiceDelegate: class {
    func deliciousBurgerDataloaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    
    var burgerArray: Array<Burger> = []
    
    func loadDeliciousBurgerData() {
        // Chicken Burgers
        burgerArray.append(Burger(id: 1, productName: "Chicken Burger", shellId: 1, proteinId: 2, condimentId: 1))
        burgerArray.append(Burger(id: 2, productName: "Chicken Burger", shellId: 2, proteinId: 2, condimentId: 1))
        burgerArray.append(Burger(id: 3, productName: "Chicken Burger", shellId: 1, proteinId: 2, condimentId: 2))
        burgerArray.append(Burger(id: 4, productName: "Chicken Burger", shellId: 2, proteinId: 2, condimentId: 2))
        
        // Beef Burgers
        burgerArray.append(Burger(id: 5, productName: "Beef Burger", shellId: 1, proteinId: 1, condimentId: 1))
        burgerArray.append(Burger(id: 6, productName: "Beef Burger", shellId: 2, proteinId: 1, condimentId: 1))
        burgerArray.append(Burger(id: 7, productName: "Beef Burger", shellId: 1, proteinId: 1, condimentId: 2))
        burgerArray.append(Burger(id: 8, productName: "Beef Burger", shellId: 2, proteinId: 1, condimentId: 2))
        
        // Salmon Burgers
        burgerArray.append(Burger(id: 9, productName: "Salmon Burger", shellId: 1, proteinId: 3, condimentId: 1))
        burgerArray.append(Burger(id: 10, productName: "Salmon Burger", shellId: 2, proteinId: 3, condimentId: 1))
        burgerArray.append(Burger(id: 11, productName: "Salmon Burger", shellId: 1, proteinId: 3, condimentId: 2))
        burgerArray.append(Burger(id: 12, productName: "Salmon Burger", shellId: 2, proteinId: 3, condimentId: 2))
        
        // Philly Burgers
        burgerArray.append(Burger(id: 13, productName: "Philly Burger", shellId: 1, proteinId: 4, condimentId: 1))
        burgerArray.append(Burger(id: 14, productName: "Philly Burger", shellId: 2, proteinId: 4, condimentId: 1))
        burgerArray.append(Burger(id: 15, productName: "Philly Burger", shellId: 1, proteinId: 4, condimentId: 2))
        burgerArray.append(Burger(id: 16, productName: "Philly Burger", shellId: 2, proteinId: 4, condimentId: 2))
        
        delegate?.deliciousBurgerDataloaded()
    }
    
}
