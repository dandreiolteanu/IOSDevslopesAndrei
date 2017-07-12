//
//  CurrentWeather.swift
//  weTheWeather
//
//  Created by Mac on 10/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Alamofire download
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            
            //let result = response.result
            //print(result)
            
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                print(dict)
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print("City Name:",self._cityName)
                    
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print("Weather type:",self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        
                        let kelvinToCelsius = (currentTemperature - 273.15)
                        
                        let kelvinToC = Double(round(10 * kelvinToCelsius/10))
                        
                        self._currentTemp = kelvinToC
                        
                        print("Current temperature:",self._currentTemp)
                    }
                }
                
            }
        completed()
        }
    }
    
}








