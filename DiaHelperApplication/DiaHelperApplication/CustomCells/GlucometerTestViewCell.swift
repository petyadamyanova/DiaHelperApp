//
//  GlucometerTestViewCell.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 8.02.24.
//

import Foundation

import UIKit

class GlucometerTestCell: UITableViewCell {
    
    private var bloodSugarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubview(bloodSugarLabel)
        addSubview(timestampLabel)
        
        NSLayoutConstraint.activate([
            bloodSugarLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bloodSugarLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            timestampLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timestampLabel.topAnchor.constraint(equalTo: bloodSugarLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func configure(with test: GlucometerBloodSugarTest) {
        bloodSugarLabel.text = "Blood Sugar: \(test.bloodSugar)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: test.timestamp) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM d, yyyy h:mm a"
            timestampLabel.text = "Date: \(displayFormatter.string(from: date))"
        } else {
            timestampLabel.text = "Invalid Timestamp"
        }
    }
}
