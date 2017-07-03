//
//  Constants.swift
//  jRain
//
//  Created by Jeane Carlos on 7/3/17.
//  Copyright © 2017 Jeane Carlos. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let API_KEY = "c83a45348aba34546a48fc8f928b1558"

//Example : http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=c83a45348aba34546a48fc8f928b1558

typealias DownloadComplete = () -> ()

//let CURRENT_WEATHER_URL = "http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=c83a45348aba34546a48fc8f928b1558"

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.lattitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(API_KEY)"


// http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=c83a45348aba34546a48fc8f928b1558
//"\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.lattitude!)\(LONGITUDE)\(Location.sharedInstance.longitude)\(APP_ID)\(API_KEY)"

//Example: http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=c83a45348aba34546a48fc8f928b1558

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.lattitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=\(API_KEY)"
