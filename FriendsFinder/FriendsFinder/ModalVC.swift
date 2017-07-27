//
//  ModalVC.swift
//  FriendsFinder
//
//  Created by Mac on 27/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ModalVC: UIViewController {

    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var latLbl: UILabel!
    @IBOutlet weak var longLbl: UILabel!
    
    var currentCity1 = String()
    var currentCountry1 =  String()
    var currentAddress1 = String()
    var currentLatitude1 = String()
    var currentLongitude1 = String()
    var nameLblStr = String()
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("^^^^^^^^^^^^^^^^^",currentCountry,currentAddress)
        cityLbl.text = currentCity1
        countryLbl.text = currentCountry1
        streetLbl.text = currentAddress1
        currentLatitude1 = currentLatitude1 + "°"
        latLbl.text = currentLatitude1
        currentLongitude1 = currentLongitude1 + "°"
        longLbl.text = currentLongitude1
        
        
    }

    @IBAction func returnMainVC(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
