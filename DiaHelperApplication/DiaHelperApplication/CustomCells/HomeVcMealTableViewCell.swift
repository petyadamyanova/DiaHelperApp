//
//  HomeVcMealTableViewCell.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 11.12.23.
//

import Foundation

import UIKit

class HomeVcMealTableViewCell: UITableViewCell {
    let timestampLabel = UILabel()
    let bloodSugarLabel = UILabel()
    let insulinDoseLabel = UILabel()
    let carbsIntakeLabel = UILabel()
    let foodTypeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        contentView.addSubview(timestampLabel)
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timestampLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timestampLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        contentView.addSubview(bloodSugarLabel)
        bloodSugarLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bloodSugarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 96),
            bloodSugarLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        contentView.addSubview(insulinDoseLabel)
        insulinDoseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            insulinDoseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 160),
            insulinDoseLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        contentView.addSubview(carbsIntakeLabel)
        carbsIntakeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carbsIntakeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 224),
            carbsIntakeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.addSubview(foodTypeLabel)
        foodTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 288),
            foodTypeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
    
