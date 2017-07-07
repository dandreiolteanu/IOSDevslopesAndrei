//
//  Car.swift
//  mvc-test
//
//  Created by Mac on 07/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

class Car {
    private var _carModel: String!
    private var _carHP: String!
    
    var carModel: String {
        get {
            return _carModel
        } set {
            _carModel = newValue
        }
    }
    
    var carHP: String {
        get {
            return _carHP

        } set {
            _carHP = newValue
        }
    }
    
    init(carModel: String, carHP: String) {
    
        self._carModel = carModel
        self._carHP = carHP
        
    }
    
    
    var carDescription: String {
        return "You drive an \(_carModel!)  which has \(_carHP!) hp"
    }
    
    /*
    func setCarModel(newCarModel: String) -> String {
        self._carModel = newCarModel
        return self._carModel
    }
    func setCarHP(newCarHP: String) -> String {
        self._carHP = newCarHP
        return self._carHP
    }
 */
    
}
