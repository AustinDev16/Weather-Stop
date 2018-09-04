//
//  MainWeatherViewController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import UIKit
import CoreLocation

let kDegree = "\u{00B0}"

class MainWeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, LocationUpdate {
    
    // MARK: - Properties
    var weatherObject: WeatherObject?
    
    // View
    let tempLabel = UILabel()
    let descriptionLabel = UILabel()
    let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    // Forecast
    var forecastCollectionView: UICollectionView?
    
    // Details
    var conditionsCollectionView: UICollectionView?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureView()
        updateView(withError: nil, message: "")
        
        
        PlacesController.shared.locationUpdateDelegate = self
        PlacesController.shared.checkForLocationPermission()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func placesTapped() {
        let vc = PlacesTableViewController(style: .plain)
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
    }
    
    @objc func refreshTapped() {
        if (self.weatherObject != nil) {
            PlacesController.shared.refreshData()
        }
    }
    
    @objc func infoTapped() {
        let infoPanel = UIAlertController(title: "Yahoo Weather", message: weatherObject?.link, preferredStyle: .alert)
        infoPanel.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        self.present(infoPanel, animated: true, completion: nil)
    }
    // MARK: - Update and LocationUpdate Protocol
    func updateViewController(weather: WeatherObject?, error: Error?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if (error != nil) {
            self.updateView(withError: error, message: "")
        } else {
            guard let update = weather else {
                self.updateView(withError: nil, message: "No data available for this location. Try again.")
                return
            }
            self.updateView(update)
        }
    }
    
    func beginUpdatingLocation() {
        updateViewPendingData()
    }
    
    func showPlacesView() {
        placesTapped()
    }
    
    // MARK: - Update View Methods
    func updateView(_ weatherObject: WeatherObject){
        
        self.tempLabel.isHidden = false
        self.tempLabel.text = "\(weatherObject.temp)" + kDegree
        self.descriptionLabel.text = weatherObject.textDescription
        self.title = "\(weatherObject.city), \(weatherObject.region)"
        self.weatherObject = weatherObject
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        
        self.conditionsCollectionView?.reloadData()
        self.conditionsCollectionView?.flashScrollIndicators()
        self.forecastCollectionView?.reloadData()
    }
    
    func updateView(withError error: Error?, message: String) {
        self.tempLabel.isHidden = false
        self.tempLabel.text = "--"
        self.descriptionLabel.text = "No data available."
        self.title = nil
        self.indicatorView.stopAnimating()
        indicatorView.isHidden = true
        
        self.conditionsCollectionView?.reloadData()
        self.forecastCollectionView?.reloadData()
        
        if (error != nil) {
            let ac = UIAlertController(title: "An Error Occurred", message: error!.localizedDescription, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            ac.addAction(dismiss)
            
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    // Update view while waiting for the API call
    func updateViewPendingData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.tempLabel.text = nil
        self.tempLabel.isHidden = true
        self.descriptionLabel.text = "Fetching Weather"
        self.title = nil
        self.weatherObject = nil
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        
        self.weatherObject = nil
        self.conditionsCollectionView?.reloadData()
        self.forecastCollectionView?.reloadData()
    }
    
    // MARK: - Configure View
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = AppearanceController.navigationBarTintColor
        self.navigationController?.navigationBar.backgroundColor = .white
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        let infoButton = UIButton(type: .detailDisclosure)
        infoButton.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
        let info = UIBarButtonItem(customView: infoButton)
        
        self.navigationItem.rightBarButtonItems = [refresh, info]
        
        let places = UIBarButtonItem(title: "Places", style: .done, target: self, action: #selector(placesTapped))
        self.navigationItem.leftBarButtonItem = places
    }
    
    func configureView() {
        
        // General Appearance
        self.view.backgroundColor = UIColor.clear
        let backgroundLayer = AppearanceController.gradientLayer()
        backgroundLayer.frame = view.frame
        self.view.layer.insertSublayer(backgroundLayer, at: 0)
        
        // Temperature label
        tempLabel.font = UIFont.systemFont(ofSize: 80, weight: UIFont.Weight.light)
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
            mainSV.heightAnchor.constraint(equalToConstant: 120)
            ])
        
        configureForecastCollectionView()
        if (self.forecastCollectionView != nil) {
            configureConditionsCollectionView(belowStackView: mainSV, aboveCollectionView: self.forecastCollectionView!)
        }
        
    }
    
    func configureConditionsCollectionView(belowStackView stackView: UIStackView, aboveCollectionView colView: UICollectionView) {
        if (conditionsCollectionView != nil) {
            return
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: self.view.bounds.width, height: 40)
        flowLayout.minimumLineSpacing = 4
        
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 196), collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsetsMake(12, 0, 4, 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: colView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor)
            ])
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(ConditionCollectionViewCell.self, forCellWithReuseIdentifier: "conditionCell")
        self.conditionsCollectionView = collectionView
    }
    
    func configureForecastCollectionView() {
        if (forecastCollectionView != nil) {
            return
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 120, height: 160)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 196), collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        let guide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 1.0),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 196)
            ])
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8)
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "forecastCell")
        self.forecastCollectionView = collectionView
    }
    
    // MARK: - CollectionView Delegate and DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.conditionsCollectionView) {
            return self.weatherObject?.conditions.count ?? 0
        } else if (collectionView == self.forecastCollectionView) {
            return self.weatherObject?.forecasts.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.conditionsCollectionView) {
            
            let cell = self.conditionsCollectionView?.dequeueReusableCell(withReuseIdentifier: "conditionCell", for: indexPath) as? ConditionCollectionViewCell
            guard let conditions = self.weatherObject?.conditions else { return UICollectionViewCell() }
            cell?.updateCell(withCondition: conditions[indexPath.row])
            
            return cell ?? UICollectionViewCell()
            
        } else if (collectionView == self.forecastCollectionView) {
            
            let cell = self.forecastCollectionView?.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as? ForecastCollectionViewCell
            
            guard let forecasts = self.weatherObject?.forecasts else { return UICollectionViewCell() }
            
            cell?.updateCell(withForecast: forecasts[indexPath.row])
            
            return cell ?? UICollectionViewCell()
        } else {
            return UICollectionViewCell()
        }
        
    }
}
