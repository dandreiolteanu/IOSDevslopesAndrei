//
//  Forecast.swift
//  weTheWeather
//
//  Created by Mac on 10/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
//    init(weatherDict: Dictionary<String, AnyObject>) {
//        
//        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
//            if let min = temp["min"] as? Double {
//            let kelvinToCelsius = (min - 273.15)
//            
//            let kelvinToC = Double(round(10 * kelvinToCelsius/10))
//            
//            min = kelvinToC
//        }
        
//    }
    
}
