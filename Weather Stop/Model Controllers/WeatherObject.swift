//
//  WeatherObject.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
// MARK: - API Dictionary Keys
private let kConditionTemp = "temp"
private let kConditionText = "text"
private let kLocationCity = "city"
private let kLocationCountry = "country"
private let kLocationRegion = "region"
private let kUnitTemp = "temperature"
private let kUnitSpeed = "speed"

class WeatherObject {
    

    // MARK: - Item Properties
    var temp: Int
    var textDescription: String
    
    // MARK: - Location Properties
    var city: String
    var country: String
    var region: String
    
    // MARK: - Units
    var tempUnit: String
    var speedUnit: String
    
    init(temp: Int, description: String, city: String, country: String, region: String, tempUnit: String, speedUnit: String) {
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

        // Extract Condition
        guard let temp = conditionDict[kConditionTemp] as? Int,
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
