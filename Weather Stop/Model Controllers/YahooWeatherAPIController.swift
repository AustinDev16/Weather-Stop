//
//  YahooWeatherAPIController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

// A class with static methods used to query and return results from the Yahoo Weather API
import Foundation

class YahooWeatherAPIController {
    // MARK: - Properties
    private static let endPointPrefix = "https://query.yahooapis.com/v1/public/yql?q="
    private static let endPointSuffix = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    
    // MARK: - Methods
    static func fetchWeather(withYQLQuery query: String,
                             completion: (Dictionary<String, Any>?, Error?)) {
        // Construct Query String
        
        // Make network call
        
        // Process Result
        
    }
}
