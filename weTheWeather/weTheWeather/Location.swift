//
//  Location.swift
//  weTheWeather
//
//  Created by Mac on 12/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

class Location {
    
    static var sharedInstance = Location()
    
    private init() {}
    
    var latitude:Double!
    var longitude:Double!
    
    
    
}
