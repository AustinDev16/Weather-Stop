//
//  PlacesController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/3/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
import CoreLocation

class PlacesController {
    // MARK: - Properties
    var places: [Place] = []
    var locationManager: CLLocationManager?
    weak var locationUpdateDelegate: LocationUpdate?
    
    static let shared = PlacesController()
    
    
    init() {
        populatePlaces()
    }
    
    private func populatePlaces() {
        // Current Location
        let currentLocation = Place(name: "Current Location")
        
        // for testing
        currentLocation.location = CLLocation(latitude: 40.7141667, longitude: -74.0063889)
        
        
        // A Few Cities
        let la = Place(name: "Los Angeles, CA")
        let slc = Place(name: "Salt Lake City, UT")
        let ny = Place(name: "New York City, NY")
        
        self.places = [currentLocation, la, slc, ny]
    }
    
    func updateViewWithCurrentLocation() {
        guard let currentLocation = self.places.first else {return}
        self.selectLocation(place: currentLocation)
    }
    
    func selectLocation(place: Place) {
        let query = place.YQLQuery()
        self.locationUpdateDelegate?.beginUpdatingLocation()
        
        WeatherObjectController.fetchWeather(withYQLQuery: query) { (weather, error) in
            self.locationUpdateDelegate?.updateViewController(weather: weather, error: error)
        }
        
    }
    
}

protocol LocationUpdate: class {
    func beginUpdatingLocation() -> Void
    func updateViewController(weather:WeatherObject?, error: Error?) -> Void
}
