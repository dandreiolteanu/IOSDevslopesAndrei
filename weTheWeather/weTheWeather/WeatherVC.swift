//
//  WeatherVC.swift
//  weTheWeather
//
//  Created by Mac on 07/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        print("############### API LINK #################")
        print(CURRENT_WEATHER_URL)
        print("############### API LINK #################")
        
        currentWeather = CurrentWeather()
        
        forecast = Forecast()
        
        currentWeather.downloadWeatherDetails{
            self.updateMainUI()
        }
    }
    
    
    
//    func downloadForecastData(completed: @escaping DownloadComplete) {
//        //Downloading forecast weather data for TableView
//        let forecastURL = URL(string: FORECAST_URL)!
//        Alamofire.request(forecastURL).responseJSON { response in
//            let result = response.result
//            
//            if let dict = result.value as? Dictionary<String, AnyObject> {
//                
//                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
//                    for obj in list {
//                        let forecast = Forecast(weatherDict: obj)
//                        self.forecasts.append(forecast)
//                    }
//                }
//                
//            }
//        }
//        
//    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        return cell
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        //Temperature
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        currentTempLabel.text = "\(formatter.string(from: currentWeather.currentTemp as NSNumber) ?? "n/a")°"
        

        currentWeatherTypeLabel.text = currentWeather.weatherType
        
        locationLabel.text = currentWeather.cityName
        
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        
    }
    

   


}

