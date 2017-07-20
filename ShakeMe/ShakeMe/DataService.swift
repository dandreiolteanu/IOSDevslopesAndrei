//
//  DataService.swift
//  ShakeMe
//
//  Created by Mac on 19/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func deliciousBurgerDataLoaded()
}

class DataService {
    
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    
    var burgerArray: Array<Burger> = []
    
    func loadDeliciousBurgerData() {
        // Chicken Burgers
        burgerArray.append(Burger(id: 1, productName: "Loaded Flour Chicken Burger", shellId: 1, proteinId: 2, condimentId: 1))
        burgerArray.append(Burger(id: 2, productName: "Loaded Corn Chicken Burger", shellId: 2, proteinId: 2, condimentId: 1))
        burgerArray.append(Burger(id: 3, productName: "Plain Flour Chicken Burger", shellId: 1, proteinId: 2, condimentId: 2))
        burgerArray.append(Burger(id: 4, productName: "Plain Corn Chicken Burger", shellId: 2, proteinId: 2, condimentId: 2))
        
        // Beef Burgers
        burgerArray.append(Burger(id: 5, productName: "Loaded Flour Beef Burger", shellId: 1, proteinId: 1, condimentId: 1))
        burgerArray.append(Burger(id: 6, productName: "Loaded Corn Beef Burger", shellId: 2, proteinId: 1, condimentId: 1))
        burgerArray.append(Burger(id: 7, productName: "Plain Flour Beef Burger", shellId: 1, proteinId: 1, condimentId: 2))
        burgerArray.append(Burger(id: 8, productName: "Plain Corn Beef Burger", shellId: 2, proteinId: 1, condimentId: 2))
        
        // Salmon Burgers
        burgerArray.append(Burger(id: 9, productName: "Loaded Flour Salmon Burger", shellId: 1, proteinId: 3, condimentId: 1))
        burgerArray.append(Burger(id: 10, productName: "Loaded Corn Salmon Burger", shellId: 2, proteinId: 3, condimentId: 1))
        burgerArray.append(Burger(id: 11, productName: "Plain Flour Salmon Burger", shellId: 1, proteinId: 3, condimentId: 2))
        burgerArray.append(Burger(id: 12, productName: "Plain Corn Salmon Burger", shellId: 2, proteinId: 3, condimentId: 2))
        
        // Philly Burgers
        burgerArray.append(Burger(id: 13, productName: "Loaded Flour Philly Burger", shellId: 1, proteinId: 4, condimentId: 1))
        burgerArray.append(Burger(id: 14, productName: "Loaded Corn Philly Burger", shellId: 2, proteinId: 4, condimentId: 1))
        burgerArray.append(Burger(id: 15, productName: "Plain Flour Philly Burger", shellId: 1, proteinId: 4, condimentId: 2))
        burgerArray.append(Burger(id: 16, productName: "Plain Corn Philly Burger", shellId: 2, proteinId: 4, condimentId: 2))
        
        delegate?.deliciousBurgerDataLoaded()
    }

}
