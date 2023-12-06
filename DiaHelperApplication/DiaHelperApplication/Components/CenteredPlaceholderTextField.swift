//
//  CenteredPlaceholderTextField.swift
//  DiaHelperApplication
//
//  Created by Petya Damyanova on 6.12.23.
//

import Foundation
import UIKit

class CenteredPlaceholderTextField: UITextField {
    private let customPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override var placeholder: String? {
        didSet {
            customPlaceholderLabel.text = placeholder
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(customPlaceholderLabel)
        customPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customPlaceholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            customPlaceholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            customPlaceholderLabel.topAnchor.constraint(equalTo: topAnchor),
            customPlaceholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
