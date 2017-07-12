//
//  WeatherCell.swift
//  weTheWeather
//
//  Created by Mac on 12/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func configureCell(forecast: Forecast) {
        //lowTemp.text = forecast.lowTemp
        //highTemp.text = forecast.highTemp
        
        //Weather type label
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        
        //Weather icon image
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
        //Low temperature formating ------>29.0 becomes 29
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        lowTemp.text = "\(formatter.string(from: forecast.lowTemp as NSNumber) ?? "n/a")°"
        
        //High temperature formating ------>29.0 becomes 29
        let formatter1 = NumberFormatter()
        formatter1.minimumFractionDigits = 0
        formatter1.maximumFractionDigits = 1
        highTemp.text = "\(formatter.string(from: forecast.highTemp as NSNumber) ?? "n/a")°"
    }
    
}
