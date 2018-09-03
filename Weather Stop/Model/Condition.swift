//
//  Condition.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import Foundation
class Condition {
    // MARK: - Properties
    let label: String
    let value: String
    
    init(label: String,
         quantity: String,
         unit: String?) {
        self.label = label
        self.value = "\(quantity) \(unit ?? "")"
    }
}
