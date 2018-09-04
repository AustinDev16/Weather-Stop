//
//  WeatherObject.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
// MARK: - API Dictionary Keys


class WeatherObject {
    
    
    // MARK: - Item Properties
    var temp: String
    var textDescription: String
    var link: String?
    
    // MARK: - Location Properties
    var city: String
    var country: String
    var region: String
    
    // MARK: - Units
    var tempUnit: String
    var speedUnit: String
    
    // MARK: - Forecasts and Conditions
    var forecasts: [Forecast] = []
    var conditions: [Condition] = []
    
    
    init(temp: String, description: String, city: String, country: String, region: String, tempUnit: String, speedUnit: String) {
        self.temp = temp
        self.textDescription = description
        self.city = city
        self.country = country
        self.region = region
        self.tempUnit = tempUnit
        self.speedUnit = speedUnit
    }
    
    convenience init?(conditionDict: Dictionary<String, Any>,
                      locationDict: Dictionary<String, String>,
                      unitDictionary: Dictionary<String, String>) {
        
        // Keys
        let kConditionTemp = "temp"
        let kConditionText = "text"
        let kLocationCity = "city"
        let kLocationCountry = "country"
        let kLocationRegion = "region"
        let kUnitTemp = "temperature"
        let kUnitSpeed = "speed"
        
        // Extract Condition
        guard let temp = conditionDict[kConditionTemp] as? String,
            let description = conditionDict[kConditionText] as? String else { return nil}
        
        // Extract Location
        guard let city = locationDict[kLocationCity],
            let country = locationDict[kLocationCountry],
            let region = locationDict[kLocationRegion] else { return nil}
        
        // Extract Units
        guard let tempUnit = unitDictionary[kUnitTemp],
            let speedUnit = unitDictionary[kUnitSpeed] else  { return nil}
        
        
        self.init(temp: temp, description: description, city: city, country: country, region: region, tempUnit: tempUnit, speedUnit: speedUnit)
    }
}
