//
//  ViewController.swift
//  mvc-test
//
//  Created by Mac on 07/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var hpField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    @IBOutlet weak var labelDesc: UILabel!
    
    let car1 = Car(carModel: "Audi A5", carHP: "200")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hpField.delegate = self
        modelField.delegate = self
        
        labelDesc.text = car1.carDescription
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hpField.resignFirstResponder()
        modelField.resignFirstResponder()
        return true
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let txt = modelField.text {
            car1.carModel = txt
            labelDesc.text = car1.carDescription
          
        }
        if let txt2 = hpField.text {
           car1.carHP = txt2
            labelDesc.text = car1.carDescription
        }
        
    }
    
    

}

