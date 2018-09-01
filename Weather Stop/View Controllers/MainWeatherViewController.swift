//
//  MainWeatherViewController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {

    // MARK: - Properties
    var weatherObject: WeatherObject?
    
    // View
    let tempLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let testQuery = "select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"(40.7141667,-74.0063889)\")"
        WeatherObjectController.fetchWeather(withYQLQuery: testQuery) { (weatherObj, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
        }
        
        configureNavigationBar()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Configure View
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = refresh
    }
    
    func configureView() {
        
    }
}
