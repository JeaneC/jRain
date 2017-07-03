//
//  Constants.swift
//  jRain
//
//  Created by Jeane Carlos on 7/3/17.
//  Copyright © 2017 Jeane Carlos. All rights reserved.
//

import Foundation

let API_KEY = "c83a45348aba34546a48fc8f928b1558" // This is my personal API Key
let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.lattitude)&lon=\(Location.sharedInstance.longitude)&appid=\(API_KEY)"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.lattitude)&lon=\(Location.sharedInstance.longitude)&cnt=10&appid=\(API_KEY)"


typealias DownloadComplete = () -> ()

func convertToFarFromKelvin (far: Double) -> Double {
        let kelvinToFar = (far * (9/5) - 459.67)
        let kelvinToFar2 = Double(round(10 * kelvinToFar/10))
        return kelvinToFar2
}
