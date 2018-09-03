//
//  PlacesController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/3/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
import CoreLocation

class PlacesController: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Properties
    var places: [Place] = []
    var locationManager: CLLocationManager = CLLocationManager()
    var locationPermission : Bool = false
    weak var locationUpdateDelegate: LocationUpdate?
    var currentLocationPlaceholder: CLLocation?
    
    static let shared = PlacesController()
    
    
    override init() {
        super.init()
        populatePlaces()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = 500 // in meters
        locationManager.distanceFilter = 1000 // in meters
        
    }
    
    // MARK: - CoreLocation Methods
    func startMonitoringLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func checkForLocationPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            PlacesController.shared.locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            // Disable location features
            disableLocation()
            locationUpdateDelegate?.showPlacesView()
            break
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            enableLocation()
            PlacesController.shared.startMonitoringLocation()
            break
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated location")
        guard let location = locations.first,
            let currentLocation = places.first else {return}

        currentLocation.location = location
        if (currentLocation.isSelected) {
            
            if (currentLocationPlaceholder != nil) {
                if (location.distance(from: currentLocationPlaceholder!) > 1000) {
                    selectLocation(place: currentLocation)
                }
            } else {
                selectLocation(place: currentLocation)
            }
            
        }
        
        currentLocationPlaceholder = location
    }
    
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocation()
            startMonitoringLocation()
            break
        case .denied,.restricted:
            disableLocation()
            locationUpdateDelegate?.showPlacesView()
        default:
            break
        }
    }
    
    // MARK: - Helper Methods
    private func populatePlaces() {
        // Current Location
        let currentLocation = Place(name: "Current Location")
        
        currentLocation.isSelected = true
        
        // A Few Cities
        let la = Place(name: "Los Angeles, CA")
        let slc = Place(name: "Salt Lake City, UT")
        let hou = Place(name: "Houston, TX")
        let chi = Place(name: "Chicago, IL")
        let boi = Place(name: "Boise, ID")
        let ny = Place(name: "New York City, NY")
        
        self.places = [currentLocation, boi, chi, hou, la, ny, slc]
    }
    
    func selectLocation(place: Place) {
        setIsSelected(forPlace: place)
        let query = place.YQLQuery()
        self.locationUpdateDelegate?.beginUpdatingLocation()
        
        WeatherObjectController.fetchWeather(withYQLQuery: query) { (weather, error) in
            self.locationUpdateDelegate?.updateViewController(weather: weather, error: error)
        }
        
    }
    
    func refreshData() {
        let selectedArray = places.filter { (place) -> Bool in
            return place.isSelected
        }
        guard let selected = selectedArray.first else { return }
        selectLocation(place: selected)
    }
    
    private func disableLocation() {
        guard let currentLocation = places.first else { return }
        currentLocation.name = "Current Location: Disabled"
        currentLocation.isDisabled = true
        currentLocation.isSelected = false
    }
    
    private func enableLocation() {
        guard let currentLocation = places.first else { return }
        currentLocation.name = "Current Location"
        currentLocation.isDisabled = false
    }
    
    private func setIsSelected(forPlace place: Place) {
        self.places.forEach { (placeObj) in
            placeObj.isSelected = false
        }
        
        place.isSelected = true
    }
    
}

protocol LocationUpdate: class {
    func beginUpdatingLocation() -> Void
    func updateViewController(weather:WeatherObject?, error: Error?) -> Void
    func showPlacesView() -> Void
}
