//
//  MainWeatherViewController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import UIKit

let kDegree = "\u{00B0}"

class MainWeatherViewController: UIViewController {

    // MARK: - Properties
    var weatherObject: WeatherObject?
    
    // View
    let tempLabel = UILabel()
    let descriptionLabel = UILabel()
    let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let testQuery = "select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"(40.7141667,-74.0063889)\")"
        WeatherObjectController.fetchWeather(withYQLQuery: testQuery) { (weatherObj, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                guard let update = weatherObject else { return }
                updateView(update)
            }
        }
        
        configureNavigationBar()
        configureView()
        
        
        updateViewPendingData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Update
    func updateView(_ weatherObject: WeatherObject){
        
        self.tempLabel.text = "\(weatherObject.temp) " + kDegree
        self.descriptionLabel.text = weatherObject.textDescription
        self.title = "\(weatherObject.city), \(weatherObject.region)"
        self.weatherObject = weatherObject
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        
    }
    
    func updateView(withError error: Error?, message: String) {
        
    }
    
    // Update view while waiting for the API call
    func updateViewPendingData() {
        self.tempLabel.text = "--"
        self.descriptionLabel.text = nil
        self.title = nil
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    // MARK: - Configure View
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = refresh
    }
    
    func configureView() {
        // Temperature label
        tempLabel.font = UIFont.systemFont(ofSize: 100)
        tempLabel.textAlignment = .center
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Description label
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        let mainSV = UIStackView(arrangedSubviews: [tempLabel, descriptionLabel, indicatorView])
        mainSV.axis = .vertical
        mainSV.distribution = .fill
        mainSV.alignment = .center
        mainSV.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainSV)
        let guide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainSV.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
            mainSV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainSV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainSV.heightAnchor.constraint(equalToConstant: 150)
            ])
        
    }
}
