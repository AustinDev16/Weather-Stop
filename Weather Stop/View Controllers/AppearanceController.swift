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
    
    static let navigationBarTintColor = UIColor(red: 39/255.0, green: 111/255.0, blue: 191/255.0, alpha: 1.0)
    static let conditionCellBackgroundColor = UIColor.white.withAlphaComponent(0.5) // 0.3
    static let forecastCellHeaderColor = UIColor(red: 39/255.0, green: 111/255.0, blue: 191/255.0, alpha: 1.0)
    static let forecastCellBackgroundColor = UIColor.white.withAlphaComponent(0.8)
    
    static func gradientLayer() -> CAGradientLayer {
        let baseBlue = UIColor(red: 41/255.0, green: 128/255.0, blue: 185/255.0, alpha: 1.0).cgColor
        let midBlue = UIColor(red: 109/255.0, green: 213/255.0, blue: 250/255.0, alpha: 1.0).cgColor
        let topWhite = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [topWhite, midBlue, baseBlue]
        gradient.locations = [0.0, 0.5, 1.0]
        
        return gradient
    }
}
