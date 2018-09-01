//
//  MainWeatherViewController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let testQuery = "select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"(40.7141667,-74.0063889)\")"
        WeatherObjectController.fetchWeather(withYQLQuery: testQuery) { (weatherObj, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
