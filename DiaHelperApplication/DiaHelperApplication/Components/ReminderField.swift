//
//  ReminderField.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 11.01.24.
//


import Foundation
import UIKit

class ReminderField: UIStackView {
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    private var stackViewHorizontal2: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
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
    
    public var endLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    public var endDateField: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.addConstraint(label.heightAnchor.constraint(equalToConstant: 30))
        
        return label
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
        stackViewHorizontal.addArrangedSubview(startLabel)
        stackViewHorizontal.addArrangedSubview(startDateField)
        
        stackView.addArrangedSubview(stackViewHorizontal)
        
        stackViewHorizontal2.addArrangedSubview(endLabel)
        stackViewHorizontal2.addArrangedSubview(endDateField)
        
        stackView.addArrangedSubview(stackViewHorizontal2)
        
        addArrangedSubview(stackView)
    }
}



