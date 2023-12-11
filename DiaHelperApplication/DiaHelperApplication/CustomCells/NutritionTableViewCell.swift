//
//  NutritionTableViewCell.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 6.12.23.
//

import UIKit

class NutritionTableViewCell: UITableViewCell {
    let leftLabel = UILabel()
    let rightTextField = CenteredPlaceholderTextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConstraints() {
        contentView.addSubview(leftLabel)
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.addSubview(rightTextField)
        rightTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightTextField.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
