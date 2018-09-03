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
    
    static let shared = PlacesController()
    
    
    override init() {
        super.init()
        populatePlaces()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = 500 // in meters
        locationManager.distanceFilter = 1000 // in meters
        
    }
    
    func startMonitoringLocation() {
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("updated location")
        guard let location = locations.first,
            let currentLocation = places.first else {return}
        currentLocation.location = location
        if (currentLocation.isSelected) {
            selectLocation(place: currentLocation)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            break
        case .authorizedAlways:
            break
        case .denied:
            fallthrough
        case .restricted:
            break;
        default:
            break
        }
    }
    private func populatePlaces() {
        // Current Location
        let currentLocation = Place(name: "Current Location")
        
        // for testing
        //currentLocation.location = CLLocation(latitude: 40.7141667, longitude: -74.0063889)
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
    
    func updateViewWithCurrentLocation() {
        guard let currentLocation = self.places.first else {return}
        self.selectLocation(place: currentLocation)
    }
    
    func selectLocation(place: Place) {
        setIsSelected(forPlace: place)
        let query = place.YQLQuery()
        self.locationUpdateDelegate?.beginUpdatingLocation()
        
        WeatherObjectController.fetchWeather(withYQLQuery: query) { (weather, error) in
            self.locationUpdateDelegate?.updateViewController(weather: weather, error: error)
        }
        
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
}
