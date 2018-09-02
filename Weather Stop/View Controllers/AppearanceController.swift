//
//  AppearanceController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
import UIKit

// All colors are stored and managed here.
class AppearanceController {
    
//    static let mainViewBackgroundColor = UIColor(red: 217/255.0, green: 225/255.0, blue: 237/255.0, alpha: 1.0)
    static let mainViewBackgroundColor = AppearanceController.forecastCellHeaderColor.withAlphaComponent(0.1)
    static let conditionCellBackgroundColor = UIColor.white.withAlphaComponent(0.5) // 0.3
    static let forecastCellBackgroundColor = UIColor.white.withAlphaComponent(0.9)
//    static let forecastCellHeaderColor = UIColor(red: 24/255.0, green: 48/255.0, blue: 89/255.0, alpha: 1.0)
    static let forecastCellHeaderColor = UIColor(red: 39/255.0, green: 111/255.0, blue: 191/255.0, alpha: 1.0)
}
