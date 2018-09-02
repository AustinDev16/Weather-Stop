//
//  ConditionCollectionViewCell.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import UIKit

class ConditionCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let label = UILabel()
    let value = UILabel()
    var viewsAreConfigured = false
    
    func updateCell(withCondition condition: Condition) {
        configureView()
        
        self.label.text = condition.label
        self.value.text = condition.value
    }
    
    private func configureView() {
        if (viewsAreConfigured) { // Prevents duplicates
            return
        }
        
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        value.textAlignment = .right
        value.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(value)
        
        NSLayoutConstraint.activate([
            // Label
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
            label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            //Value
            value.topAnchor.constraint(equalTo: contentView.topAnchor),
            value.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            value.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),
            value.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
            ])
    }
}
