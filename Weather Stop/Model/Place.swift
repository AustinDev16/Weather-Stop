//
//  Place.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/3/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
import CoreLocation

class Place {
    //MARK: - Properties
    var name: String
    var location: CLLocation?
    var isSelected: Bool = false
    var isDisabled: Bool = false
    
    init(name: String) {
        self.name = name
    }
    
    //MARK: - Methods
    func YQLQuery() -> String {
        if (location != nil) {
            // Query should be in lat/long format
            return "select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"(\(location!.coordinate.latitude),\(location!.coordinate.longitude))\")"
        } else {
            // Query should be city name.
            return "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(name)\")"
        }
    }
}
