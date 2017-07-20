//
//  WeatherVC.swift
//  weTheWeather
//
//  Created by Mac on 07/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import RevealingSplashView

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, Blurring {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var entryPointView: UIView!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Location Manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        //End Location Manager

        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        let splashView = RevealingSplashView(iconImage: UIImage(named: "LocationEntryPoint")!, iconInitialSize: CGSize(width: 300, height: 300), backgroundColor: UIColor.clear)
        self.entryPointView.addSubview(splashView)
        splashView.animationType = SplashAnimationType.swingAndZoomOut

        splashView.startAnimation() {
            print("ANIMATING SPLASH VIEW")
        }
        self.unblurWithDuration(duration: 2.0)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        self.entryPointView.isHidden = true
//        self.unblurWithDuration(duration: 2.0)


    }
    
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails{
                self.downloadForecastData {
                    self.updateMainUI()
//                    self.entryPointView.isHidden = true
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        Alamofire.request(FORECAST_URL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
        
    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        
        //Temperature
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        currentTempLabel.text = "\(formatter.string(from: currentWeather.currentTemp as NSNumber) ?? "n/a")°"
        

        currentWeatherTypeLabel.text = currentWeather.weatherType
        if currentWeather.cityName == "Certeju De Sus" {
            locationLabel.text = "Bánffy Castle"
            mainImage.image = UIImage(named: "Electric castle-1")
        } else {
            locationLabel.text = currentWeather.cityName

        }
//        locationLabel.text = currentWeather.cityName
        
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        
    }
    

   


}

