//
//  TextInput2.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 27.11.23.
//

import Foundation

import UIKit

class TextInput2: UIStackView {
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    public var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    public var errorField: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Error"
        
        return label
    }()
    
    public var textField: UITextField = {
        let textField = UITextField()
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 35))
  
        if let color = UIColor(named: "newBrown") {
            textField.layer.borderColor = color.cgColor
        } else {
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }
        
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
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(errorField)
        errorField.isHidden = true
        
        addArrangedSubview(stackView)
    }
}
