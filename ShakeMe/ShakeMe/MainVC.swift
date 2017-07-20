//
//  MainVC.swift
//  ShakeMe
//
//  Created by Mac on 19/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class MainVC: UIViewController, DataServiceDelegate {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    
//    var ds: DataService = DataService.instance
    var burgerArray: Array<Burger> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Chicken Burger
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

        print(burgerArray.count)
        print(burgerArray[0].proteinId.rawValue)
        
        
        
        
        
        
        
//        ds = DataService.instance
//        ds.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        headerView.addDropShadow()
        let nib = UINib(nibName: "BurgerCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BurgerCell")
        
    }
    
    func deliciousBurgerDataLoaded() {
        print("You need to include me for delegate to work!")
    }

}

extension MainVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return burgerArray.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerCell", for: indexPath) as? BurgerCell {
            
            cell.configureCell(burger: burgerArray[indexPath.row])
            print("asda")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}

