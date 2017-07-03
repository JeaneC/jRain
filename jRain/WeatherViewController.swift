//
//  WeatherViewController.swift
//  jRain
//
//  Created by Jeane Carlos on 7/2/17.
//  Copyright © 2017 Jeane Carlos. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    
    var currentLocation: CLLocation!
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80 //Unfortunately this is the manual way to do it since changing the rowHeight settings in the storyboard is bugged as of XCode 8.3.3
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.downloadAndUpdate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.downloadAndUpdate()
    }
    
    func downloadAndUpdate() {
        forecasts.removeAll(keepingCapacity: true) //This is to reset the list
        locationAuthStatus() //Methods should come after this because we need the coordinates to do something
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData{
                self.updateMainUI()
            }
        }
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            if let currentLocation = locationManager.location { //In case the location doesn't work
            Location.sharedInstance.lattitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            } else {
                print("Tap to refresh")
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
            
        } else {
            
        return WeatherTableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Download forecast weather data for TableView
        
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0) //The list doesn't need to start with today
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(currentWeather.currentTemp)
        currentWeatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherIcon.image = UIImage(named: currentWeather.weatherType)
    }
    


}

