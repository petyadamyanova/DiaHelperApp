//
//  InsulinCanulaReminderField.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 14.01.24.
//

import Foundation
import UIKit

class InsulinCanulaReminderField: UIStackView {
    private var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    
    public var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    public var startLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    public var startDateField: UITextField = {
        let textField = UITextField()
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 30))
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        stackView.addArrangedSubview(startLabel)
        stackView.addArrangedSubview(startDateField)
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(stackView)
        
        addArrangedSubview(verticalStackView)
    }
}



