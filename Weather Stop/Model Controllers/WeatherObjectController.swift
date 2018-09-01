//
//  WeatherObjectController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
class WeatherObjectController {
    
    // Initiates call to API, handles completion on main thread.
    static func fetchWeather(withYQLQuery query: String,
                             completion: @escaping (WeatherObject?, Error?) -> Void) {
        
        YahooWeatherAPIController.fetchWeather(withYQLQuery: query) { (response, error, success) in
            if (success) {
                let newWeatherObj = buildWeatherObject(fromDictionary: response)
                DispatchQueue.main.async {
                    completion(newWeatherObj, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        } //end block
        
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
        
        let weather = WeatherObject.init(conditionDict: condition, locationDict: location, unitDictionary: units)
        
        // Forecasts
        guard let forecasts = item["forecast"] as? [Dictionary<String, Any>] else {return weather }
        
        forecasts.forEach { (forecastDict) in
            let newForecast = Forecast(dictionary: forecastDict, isToday: false)
            if (newForecast != nil) {
                weather?.forecasts.append(newForecast!)
            }
        }
        
        
        
        return weather
    }
}
