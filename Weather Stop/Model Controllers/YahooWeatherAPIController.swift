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
                             completion: @escaping (Dictionary<String, Any>?, Error?, Bool) -> Void) {
        
        // Construct Query String
        // YQL -> percent encoded string
        guard let percentEncodedStr = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else { completion(nil, nil, false); return;}
        let fullURLString = endPointPrefix + percentEncodedStr + endPointSuffix
        print(fullURLString)
        
        // Make network call
        guard let url = URL(string: fullURLString) else {completion(nil, nil, false); return;}
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let downloadTask = urlSession.dataTask(with: url) { (data, response, error) in
            if (data != nil) {
                do {
                    // Process Result
                    let responseDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
                    
                    // Check for error message}
                    if (responseDictionary != nil) { // Response exists
                        if let errorDictionary = responseDictionary!["error"] as? Dictionary<String, String> { // Response is in error
                            guard errorDictionary["description"] != nil else { completion(nil, nil, false); return;}
                            completion(errorDictionary, nil, false)
                        } else { // Response is valid
                            completion(responseDictionary, nil, true)
                        }
                    } else {
                        completion(nil, nil, false)
                    }
                } catch {
                    // Error occurred fetching response or parsing result
                    completion(nil, error, false)
                }
            } else {
                completion(nil, error, false)
            }
        }
        
        downloadTask.resume()
    }
}
