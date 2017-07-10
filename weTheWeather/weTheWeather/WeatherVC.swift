//
//  WeatherVC.swift
//  weTheWeather
//
//  Created by Mac on 07/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        print("############### API LINK #################")
        print(CURRENT_WEATHER_URL)
        print("############### API LINK #################")
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            //Setup UI to load downloaded data
            self.updateMainUI()
            print(dateLabel.text!)
            print(currentTempLabel.text!)
            print("\(currentWeather.currentTemp)")
            print(currentWeather.cityName)




            print("aaa")
        }
    }
    
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
        
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        
        currentWeatherTypeLabel.text = currentWeather.weatherType
        
        locationLabel.text = currentWeather.cityName
        
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        
    }
    

   


}

