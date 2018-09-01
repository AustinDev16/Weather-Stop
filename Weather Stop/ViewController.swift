//
//  ViewController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testQuery = "select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"(40.7141667,-74.0063889)\")"
        YahooWeatherAPIController.fetchWeather(withYQLQuery: testQuery) { (dictionary, error, success) in
            if (success) {
                
            } else {
                print ("Error fetching:")
                print (error ?? "")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

