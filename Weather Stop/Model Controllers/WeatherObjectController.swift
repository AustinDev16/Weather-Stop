//
//  WeatherObjectController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
class WeatherObjectController {
    
    // Initiates call to API, handles completion.
    static func fetchWeather(withYQLQuery query: String,
                             completion: (WeatherObject?, Error?) -> Void) {
        
        YahooWeatherAPIController.fetchWeather(withYQLQuery: query) { (response, error, success) in
            if (success) {
                let newWeatherObj = buildWeatherObject(fromDictionary: response)
                completion(newWeatherObj, nil)
            } else {
                completion(nil, error)
            }
        }
        
    }
    
    // Builds object from API response
    static func buildWeatherObject(fromDictionary dict:Dictionary<String, Any>?) -> WeatherObject? {
        
        guard let response = dict else { return nil }
        print(response)
        // Extract out channel from response
        guard let query = response["query"] as? Dictionary<String, Any>,
        let result = query["results"] as? Dictionary<String, Any>,
        let channel = result["channel"] as? Dictionary<String, Any> else { return nil }
        
        
        // Extract Individual channels
        
        // Item
        guard let item = channel["item"] as? Dictionary<String, Any>,
        let condition = item["condition"] as? Dictionary<String, Any> else {return nil}
        
        // Location
        guard let location = channel["location"] as? Dictionary<String, String> else {return nil}
        
        // Units
        guard let units = channel["units"] as? Dictionary<String, String> else { return nil }
        
        return WeatherObject.init(conditionDict: condition, locationDict: location, unitDictionary: units)
    }
}
