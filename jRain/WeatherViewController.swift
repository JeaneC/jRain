//
//  WeatherViewController.swift
//  jRain
//
//  Created by Jeane Carlos on 7/2/17.
//  Copyright © 2017 Jeane Carlos. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80 //Unfortunately this is the manual way to do it, since it's bugged
        currentWeather.downloadWeatherDetails {
            //setup UI to load download data
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    


}

