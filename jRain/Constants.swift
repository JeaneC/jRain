//
//  Constants.swift
//  jRain
//
//  Created by Jeane Carlos on 7/3/17.
//  Copyright © 2017 Jeane Carlos. All rights reserved.
//

import Foundation

let BASE_URL = "http://samples.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "c83a45348aba34546a48fc8f928b1558"

//Example : http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=c83a45348aba34546a48fc8f928b1558

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = BASE_URL + LATITUDE + LONGITUDE + APP_ID + API_KEY
