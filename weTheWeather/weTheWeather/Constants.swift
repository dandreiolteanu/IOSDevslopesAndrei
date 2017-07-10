//
//  Constants.swift
//  weTheWeather
//
//  Created by Mac on 10/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"

let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "e1eb26b38a40f9d71f6a2e8a6a3a1e74"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)-20\(LONGITUDE)44\(APP_ID)\(API_KEY)"
