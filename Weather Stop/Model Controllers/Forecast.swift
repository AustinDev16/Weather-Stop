//
//  Forecast.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
class Forecast {
    // MARK: - Properties
    let day: String
    let high: String
    let low: String
    let textDescription: String
    
    let isToday: Bool
    
    init(day: String,
         high: String,
         low: String,
         text: String,
         isToday: Bool = false) {
        self.day = day
        self.high = high
        self.low = low
        self.textDescription = text
        self.isToday = isToday
    }
    
    convenience init?(dictionary: Dictionary<String, Any>, isToday: Bool = false) {
        let kDay = "day"
        let kHigh = "high"
        let kLow = "low"
        let kDescription = "text"
        
        guard let day = dictionary[kDay] as? String,
        let high = dictionary[kHigh] as? String,
        let low = dictionary[kLow] as? String,
        let text = dictionary[kDescription] as? String else { return nil }
        
        self.init(day: day, high: high, low: low, text: text, isToday: isToday)
    }
}
