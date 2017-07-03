//
//  WeatherViewController.swift
//  jRain
//
//  Created by Jeane Carlos on 7/2/17.
//  Copyright © 2017 Jeane Carlos. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80 //Unfortunately this is the manual way to do it, since it's bugged
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData{
               self.updateMainUI()
            }
            
        }
        // Do any additional setup after loading the view, typically from a nib.
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
                    self.forecasts.remove(at: 0)
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

