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
        
        return nil
    }
}
