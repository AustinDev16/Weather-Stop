//
//  ForecastCollectionViewCell.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/1/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let dayLabel = UILabel()
    let highLabel = UILabel()
    let lowLabel = UILabel()
    let textLabel = UILabel()
    var stackView: UIStackView?
    
    // MARK: - Update Methods
    func updateCell(withForecast forecast: Forecast) {
        configureView()
        dayLabel.text = forecast.day
        highLabel.text = forecast.high
        lowLabel.text = forecast.low
        textLabel.text = forecast.textDescription
    }
    
    private func configureView() {
        if (self.stackView != nil) { // Prevents adding duplicate views to cell.
            return
        }
        self.backgroundColor = .white
        // Day Label
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(dayLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            dayLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        // Stack View: High, Low, Text
        
        highLabel.textAlignment = .center
        highLabel.font = UIFont.systemFont(ofSize: 28)
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        
        lowLabel.textAlignment = .center
        lowLabel.font = UIFont.systemFont(ofSize: 28)
        lowLabel.textColor = .gray
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [highLabel, lowLabel, textLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4)
            ])
        
        self.stackView = stackView
        
    }
}