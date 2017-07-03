//
//  Location.swift
//  jRain
//
//  Created by Jeane Carlos on 7/3/17.
//  Copyright © 2017 Jeane Carlos. All rights reserved.
//

import CoreLocation


class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var lattitude: Double!
    var longitude: Double!
}
